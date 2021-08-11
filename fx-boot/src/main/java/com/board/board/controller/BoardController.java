package com.board.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.board.model.BoardMaster;
import com.board.common.service.CommonService;
import com.board.common.service.LoginService;

@RestController
@RequestMapping(value="/")
public class BoardController {

	@Autowired
	LoginService loginService;
	@Autowired
	CommonService service;
/*
 * Login Check 필요한 페이지의 경우 @RequestMapping 위에 @LoginCheck 어노테이션을 추가해줄것.
 * */
	@RequestMapping(value = "/home.do")
	public ModelAndView home(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession(false); //Home 진입시 Session에 담긴 정보를 가져오기 위함
		String ticket = "";
		String empCode = "";
		if(session.getAttribute("ticket") != null) {
			ticket = session.getAttribute("ticket").toString(); //최초 로그인시 session에 담긴 sso ticket을 가져옴
		}else {
			mv.setViewName("redirect:/Login/Login.do"); //ticket정보가 session에 없을 경우(logout, 다른사용자 로그인) loginForm으로 이동시키기 위함
			return mv;
		}
		empCode = getUser(ticket, request); //session에 담긴 ticket을 이용하여 사용자 정보 조회 (최초 1회 > home이동시 session에 있는 usermaster정보를 가져옴)
		mv.setViewName("main/home");
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
	@RequestMapping(value = "/board-main.do")
	public ModelAndView board_main(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<BoardMaster> boardList = service.getBoardTest();
		mv.setViewName("boards/board-main");
		mv.addObject("boardList", boardList);
		return mv;
	}



}
