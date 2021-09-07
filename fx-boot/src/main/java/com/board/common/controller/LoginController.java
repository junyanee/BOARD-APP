package com.board.common.controller;

import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.common.service.LoginService;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping(value="/Login")
public class LoginController {
	@Autowired
	LoginService service;
	String ticket = "";
	@RequestMapping(value = "/Login.do")
	public ModelAndView Login(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		// HTTPSession 존재하면 세션 반환, 없으면 세션 생성
		HttpSession session = request.getSession(true);
		if(session.getAttribute("userInfo") == null) {
			// sso 서버에서 빈 티켓 발행
			ticket = service.ssoLegasy();
			mv.setViewName("login/ssoLogin");
			mv.addObject("ticket", ticket);
			session.setAttribute("ticket", ticket);
			mv.addObject("url", "'home.do'");
		}
		else {
			session.setAttribute("ticket", null);
			session.setAttribute("userInfo", null);
			mv.setViewName("login/loginForm");
		}
		return mv;
	}

	@RequestMapping(value = "/LoginProc.do")
	public String LoginProc(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, Object> param) throws Exception {
		String ajaxResult = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String userId = (String)param.get("userId");
		String userPw = (String)param.get("userPw");
		if(service.SYADLoginCheck(userId, userPw)) {
			service.setSessionUserInfo(request, userId);
			resultMap.put("loginCheck", true);
		}
		else {
			resultMap.put("loginCheck", false);
		}
		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}

//	@RequestMapping(value = "/LoginProc.do")
//	public ModelAndView LoginProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		ModelAndView mv = new ModelAndView();
//		String userId = request.getParameter("userId");
//		String userPw = request.getParameter("userPw");
//		if(service.SYADLoginCheck(userId, userPw)) {
//			service.setSessionUserInfo(request, userId);
//			mv.setViewName("redirect:/home.do");
//		}
//		else {
//			response.setContentType("text/html; charset=UTF-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script>alert('ID와 PW를 확인하세요');</script>");
//			out.flush();
//			mv.setViewName("login/loginForm");
//		}
//		return mv;
//	}

}
