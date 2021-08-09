package com.board.common.controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.common.service.LoginService;

@RestController
@RequestMapping(value="/Login")
public class LoginController {
	@Autowired
	LoginService service;
	String ticket = "";
	@RequestMapping(value = "/Login.do")
	public ModelAndView Login(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		// HTTPSession 존재하면 세션 반환, 없으면 세션 생성
		HttpSession session = request.getSession(true);
		String userId = "";
		if(session.getAttribute("userId") != null) {
			userId = session.getAttribute("userId").toString();
		}
		try {
			if(userId.equals("")) {
				ticket = service.ssoLegasy();
				mv.setViewName("login/loginForm");
				// mv.setViewName("login/ssoLogin");
				mv.addObject("ticket", ticket);
				session.setAttribute("ticket", ticket);
				// home으로 가지마!
				// mv.addObject("url", "'home.do'");
			}
			else {
				session.setAttribute("ticket", null);
				session.setAttribute("userId", null);
				mv.setViewName("login/loginForm");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return mv;
	}

	@RequestMapping(value = "/LoginProc.do")
	public ModelAndView LoginProc(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		if(!service.SYADLoginCheck(userId, userPw)) {
			mv.setViewName("login/login");
			return mv;
		}
		else {


		}
		//mv.setViewName("login/login");
		return mv;
	}

}
