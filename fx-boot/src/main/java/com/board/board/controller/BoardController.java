package com.board.board.controller;

import java.io.PrintWriter;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.board.model.BoardMaster;
import com.board.board.service.BoardService;
import com.board.common.model.ParameterWrapper;
import com.board.common.model.UserMaster;
import com.board.common.service.LoginService;

@RestController
@RequestMapping(value="/")
public class BoardController {

	@Autowired
	LoginService loginService;
	@Autowired
	BoardService boardService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

/*
 * Login Check 필요한 페이지의 경우 @RequestMapping 위에 @LoginCheck 어노테이션을 추가해줄것.
 * */
	@RequestMapping(value = "/home.do")
	public ModelAndView home(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		//최초 홈 접근시 세션이 없을 경우 세션 객체 생성함.
		HttpSession session = request.getSession(true);

		//Home 진입시 Session에 담긴 정보를 가져오기 위함
		getUser(request);
		UserMaster userVo = (UserMaster)session.getAttribute("userInfo");

		if(userVo == null) {
			//ticket정보가 session에 없을 경우(logout, 다른사용자 로그인) loginForm으로 이동시키기 위함
			mv.setViewName("redirect:/Login/Login.do");
		}
		else {
			mv.setViewName("main/home");
		}
		return mv;
	}
	//session 정보를 활용한 getUser
	private void getUser(HttpServletRequest request) throws Exception{
		loginService.ssoGetUserId(request);
	}

	// 전체 게시판 불러오기
	@RequestMapping(value = "/board-main.do")
	public ModelAndView board_main(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<BoardMaster> boardList = boardService.getBoardTest();
		mv.setViewName("boards/boardList");
		mv.addObject("boardList", boardList);
		return mv;
	}
	// 새 게시글 작성 페이지 호출 (GET)
	@RequestMapping(value = "/boardWrite", method = RequestMethod.GET)
	public ModelAndView boardWriteGET(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("boards/boardWrite");
		return mv;
	}

	// 새 게시글 작성 (POST)
	@LoginCheck
	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public ModelAndView boardWritePOST(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster)session.getAttribute("userInfo");
		//String userId = session.getAttribute("userId").toString();
		BoardMaster boardMaster = new BoardMaster();
		boardMaster.setTitle(request.getParameter("newArticle.title"));
		boardMaster.setContents(request.getParameter("newArticle.contents"));
		boardMaster.setInsuser(userMaster.getEmpCode());
		boardMaster.setModuser(userMaster.getEmpCode());
		if (boardMaster.getTitle().equals("")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter Out = response.getWriter();
			Out.println("<script>alert('제목을 입력해주세요.');</script>");
			Out.flush();
		} else {
			if (boardMaster.getContents().equals("")) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter Out = response.getWriter();
				Out.println("<script>alert('내용을 입력해주세요.');</script>");
				Out.flush();
			} else {
				mv.addObject("boardDetail", boardMaster);
				mv.setViewName("redirect:/board-main.do");
				boardService.insertArticle(boardMaster);
				return mv;
			}
		}
		mv.setViewName("boards/boardWrite");
		return mv;

	}


	// 선택된 게시글 조회(GET)
	@RequestMapping(value = "/boardDetail", method = RequestMethod.GET)
	public ModelAndView getArticle(HttpServletRequest request, ModelAndView mv) throws Exception {
		int boardIdx = Integer.parseInt(request.getParameter("idx"));
		BoardMaster boardArticle = boardService.getArticle(boardIdx);
		mv.addObject("getArticle", boardArticle);
		mv.setViewName("boards/boardDetail");

		return mv;
	}

	@RequestMapping(value = "/getBoardTest.do")
	public List<BoardMaster> getBoardTest(HttpServletRequest request, @RequestBody ParameterWrapper<BoardMaster> param) throws Exception {
		logger.debug("=============getBoardTest Call =============");
		logger.debug("=============getBoardTest Call =============");
		return boardService.getBoardTest();
	}



}
