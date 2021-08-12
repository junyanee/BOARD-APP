package com.board.board.controller;

import java.net.http.HttpRequest;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.board.model.BoardMaster;
import com.board.board.service.BoardService;
import com.board.common.model.ParameterWrapper;
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
		HttpSession session = request.getSession(false); //Home 진입시 Session에 담긴 정보를 가져오기 위함
		String ticket = "";
		String empCode = "";
		/*
		if(session.getAttribute("ticket") == null) {
			mv.setViewName("redirect:/Login/Login.do"); //ticket정보가 session에 없을 경우(logout, 다른사용자 로그인) loginForm으로 이동시키기 위함
			return mv;
		}*/

		empCode = getUser(ticket, request); //session에 담긴 ticket을 이용하여 사용자 정보 조회 (최초 1회 > home이동시 session에 있는 usermaster정보를 가져옴)
		if(!empCode.equals("")) {
			mv.setViewName("main/home");
		}
		else {
			mv.setViewName("redirect:/Login/Login.do"); //ticket정보가 session에 없을 경우(logout, 다른사용자 로그인) loginForm으로 이동시키기 위함
		}

		//User Master > getUserMaster > add Session - User Master

		return mv;
	}
	//session 정보를 활용한 getUser
	private String getUser(String ticket, HttpServletRequest request) throws Exception{
		String empCode = "";
		HttpSession session = request.getSession(false);
		if(session.getAttribute("userId") != null) {
			empCode = session.getAttribute("userId").toString();
		}
		else {
			empCode = loginService.ssoGetUserId(ticket, request);
		}
		return empCode;
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
	// @LoginCheck
	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public ModelAndView boardWritePOST(HttpServletRequest request, ModelAndView mv) throws Exception {
		HttpSession session = request.getSession(false);
		String userId = session.getAttribute("userId").toString();
		BoardMaster boardMaster = new BoardMaster();
		boardMaster.setTitle(request.getParameter("newArticle.title"));
		boardMaster.setContents(request.getParameter("newArticle.contents"));
		boardMaster.setInsuser("SYC221336");
		boardMaster.setModuser("SYC221336");
		// boardMaster.setInsuser(userId);
		// boardMaster.setModuser(userId);
		mv.addObject("newArticle", boardMaster);
		mv.setViewName("redirect:/board-main.do");
		boardService.insertArticle(boardMaster);
		logger.debug("=============boardWritePOST Call =============");
		return mv;
	}

	// 선택된 게시글 조회(GET)
	@RequestMapping(value = "/getBoardContents", method = RequestMethod.GET)
	public ModelAndView getArticle(HttpServletRequest request, ModelAndView mv) throws Exception {
		String boardIdx = request.getParameter("idx");
		List<BoardMaster> boardArticle = boardService.getArticle(boardIdx);
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
