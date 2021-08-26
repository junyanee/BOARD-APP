package com.board.board.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.board.model.BoardMaster;
import com.board.board.model.CommentMaster;
import com.board.board.model.FileMaster;
import com.board.board.service.BoardService;
import com.board.board.service.CommentService;
import com.board.common.model.UserMaster;
import com.board.common.service.LoginService;
import com.board.utility.Search;

import ch.qos.logback.classic.Logger;

@RestController
@RequestMapping(value = "/")
public class BoardController {

	@Autowired
	LoginService loginService;
	@Autowired
	BoardService boardService;
	@Autowired
	CommentService commentService;

	/*
	 * Login Check 필요한 페이지의 경우 @RequestMapping 위에 @LoginCheck 어노테이션을 추가해줄것.
	 */
	@RequestMapping(value = "/home.do")
	public ModelAndView home(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		// 최초 홈 접근시 세션이 없을 경우 세션 객체 생성함.
		HttpSession session = request.getSession(true);

		// Home 진입시 Session에 담긴 정보를 가져오기 위함
		getUser(request);
		UserMaster userVo = (UserMaster) session.getAttribute("userInfo");

		if (userVo == null) {
			// ticket정보가 session에 없을 경우(logout, 다른사용자 로그인) loginForm으로 이동시키기 위함
			mv.setViewName("redirect:/Login/Login.do");
		} else {
			mv.setViewName("main/home");
		}
		return mv;
	}

	// session 정보를 활용한 getUser
	private void getUser(HttpServletRequest request) throws Exception {
		loginService.ssoGetUserId(request);
	}

	// 전체 게시판 불러오기
	@RequestMapping(value = "/board-main.do")
	public ModelAndView board_main(HttpServletRequest request,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String keyword, @ModelAttribute("search") Search search) throws Exception {
		ModelAndView mv = new ModelAndView();

		// Search
		mv.addObject("search", search);
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		// Pagination
		int listCnt = boardService.getBoardListCnt(search);
		search.pageInfo(page, range, listCnt);
		List<BoardMaster> boardList = boardService.getBoardList(search);
		mv.addObject("pagination", search);
		mv.addObject("boardList", boardList);
		mv.setViewName("boards/boardList");
		return mv;
	}

	// 새 게시글 작성 페이지 호출 (GET)
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.GET)
	public ModelAndView boardWriteGET(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("boards/boardWrite");
		return mv;
	}

	// 새 게시글 작성 (POST)
	@LoginCheck
	@RequestMapping(value = "/boardWrite.do", method = RequestMethod.POST)
	public ModelAndView boardWritePOST(MultipartHttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		BoardMaster boardMaster = new BoardMaster();
		boardMaster.setTitle(request.getParameter("newArticle.title"));
		boardMaster.setContents(request.getParameter("newArticle.contents"));
		boardMaster.setInsuser(userMaster.getEmpCode());
		boardMaster.setModuser(userMaster.getEmpCode());

		// Validation Check
		if (boardMaster.getTitle().equals("")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('제목을 입력해주세요.');</script>");
			out.flush();
		} else {
			if (boardMaster.getContents().equals("")) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('내용을 입력해주세요.');</script>");
				out.flush();
			} else {
				mv.addObject("boardDetail", boardMaster);
				mv.setViewName("redirect:/board-main.do");
				/* 게시글 먼저 삽입하고 이후에 파일 삽입 */
				// 게시글 삽입하면서 해당 IDX 가져옴
				int boardIdx = boardService.insertArticle(boardMaster);

				// 가져온 게시글 IDX 에 맞게 파일 삽입
				List<MultipartFile> multiFileList = request.getFiles("uploadFile");
				FileMaster fileMaster = new FileMaster();

				for (MultipartFile file : multiFileList) {
					fileMaster.setBoardIdx(boardIdx);
					fileMaster.setOrgFileName(file.getOriginalFilename()); // 파일 이름
					fileMaster.setFileBytes(file.getBytes()); // 파일 바이너리
					fileMaster.setFileSize(file.getSize()); // 파일 사이즈
					fileMaster.setInsuser(userMaster.getEmpCode());
					fileMaster.setModuser(userMaster.getEmpCode());
					boardService.uploadFile(fileMaster);
				}
				return mv;
			}
		}
		mv.setViewName("boards/boardWrite");
		return mv;
	}

	// 선택된 게시글 조회(GET)
	@RequestMapping(value = "/boardDetail.do", method = RequestMethod.GET)
	public ModelAndView getArticle(HttpServletRequest request, ModelAndView mv) throws Exception {
		int boardIdx = Integer.parseInt(request.getParameter("idx"));
		BoardMaster boardArticle = boardService.getArticle(boardIdx);
		List<FileMaster> fileList = boardService.getFileList(boardIdx);
		mv.addObject("fileList", fileList);
		List<CommentMaster> commentList = commentService.getComment(boardIdx);
		boardService.updateReadCnt(boardIdx);
		mv.addObject("getArticle", boardArticle);
		mv.addObject("commentList", commentList);
		mv.setViewName("boards/boardDetail");
		return mv;
	}

	// 파일 다운로드
	@RequestMapping(value = "/downloadBoardFile.do")
	public void downloadBoardFile(@RequestParam int idx, HttpServletResponse response) throws Exception {
		FileMaster fileMaster = boardService.downloadFile(idx);
		byte[] file = fileMaster.getFileBytes();
		response.setContentType("application/x-msdownload");
		response.setContentLength(file.length);
		response.addHeader("Content-Disposition",
				"attachment;filename=\"" + URLEncoder.encode(fileMaster.getOrgFileName(), "UTF-8") + "\";");
		response.getOutputStream().write(file);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	// 선택된 게시글 수정(GET)
	@LoginCheck
	@RequestMapping(value = "/boardModify.do", method = RequestMethod.GET)
	public ModelAndView modifyArticleGET(HttpServletRequest request, ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		int boardIdx = Integer.parseInt(request.getParameter("idx"));
		BoardMaster boardArticle = boardService.getArticle(boardIdx);
		if (userMaster.getEmpCode().equals(boardArticle.getInsuser())) {
			mv.addObject("modifyArticle", boardArticle);
			mv.setViewName("boards/boardModify");
			return mv;
		} else {
			mv.setViewName("redirect:/board-main.do");
			return mv;
		}
	}

	// 선택된 게시글 수정(POST)
	@LoginCheck
	@RequestMapping(value = "/boardModify.do", method = RequestMethod.POST)
	public ModelAndView modifyArticlePOST(MultipartHttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		BoardMaster boardMaster = new BoardMaster();
		boardMaster.setIdx(Integer.parseInt(request.getParameter("idx")));
		boardMaster.setTitle(request.getParameter("modifyArticle.title"));
		boardMaster.setContents(request.getParameter("modifyArticle.contents"));
		boardMaster.setModuser(userMaster.getEmpCode());

		// Validation Check
		if (boardMaster.getTitle().equals("")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('제목을 입력해주세요.');</script>");
			out.flush();
		} else {
			if (boardMaster.getContents().equals("")) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('내용을 입력해주세요.');</script>");
				out.flush();
			} else {
				mv.addObject("boardDetail", boardMaster);
				mv.setViewName("redirect:/board-main.do");

				// 기존 글에서 업로드 한 파일 가져옴
				List<FileMaster> fileList = boardService.getFileList(boardMaster.getIdx());

				// 수정 시 업로드 한 파일 가져옴
				List<MultipartFile> multiFileList = request.getFiles("uploadFile");
				FileMaster fileMaster = new FileMaster();

				// 수정 시 업로드 한 파일 세팅
				for (MultipartFile file : multiFileList) {
					fileMaster.setBoardIdx(boardMaster.getIdx());
					fileMaster.setOrgFileName(file.getOriginalFilename()); // 파일 이름
					fileMaster.setFileBytes(file.getBytes()); // 파일 바이너리
					fileMaster.setFileSize(file.getSize()); // 파일 사이즈
					fileMaster.setInsuser(userMaster.getEmpCode());
					fileMaster.setModuser(userMaster.getEmpCode());

					// 기존 업로드 파일과 수정 시 업로드 한 파일명 같은지 비교
					// 같으면 DB에 저장, 다르면 저장 x
					for (FileMaster elem : fileList) {
						if (!elem.getOrgFileName().equals(fileMaster.getOrgFileName())) {
							boardService.uploadFile(fileMaster);
						}
					}
				}
				mv.addObject("modifyArticle", boardMaster);
				mv.setViewName("redirect:/board-main.do");
				boardService.modifyArticle(boardMaster);
				return mv;
			}
		}
		return mv;
	}

	// 선택된 게시글 삭제(GET)
	@LoginCheck
	@RequestMapping(value = "/boardDelete.do", method = RequestMethod.GET)
	public ModelAndView deleteArticlePOST(HttpServletRequest request, ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		int boardIdx = Integer.parseInt(request.getParameter("idx"));
		BoardMaster boardMaster = boardService.getArticle(boardIdx);
		if (userMaster.getEmpCode().equals(boardMaster.getInsuser())) {
			boardMaster.setIdx(Integer.parseInt(request.getParameter("idx")));
			boardMaster.setModuser(userMaster.getEmpCode());
			boardService.deleteArticle(boardMaster);
			mv.setViewName("redirect:/board-main.do");
			return mv;
		} else {
			mv.setViewName("redirect:/board-main.do");
			return mv;
		}
	}
}
