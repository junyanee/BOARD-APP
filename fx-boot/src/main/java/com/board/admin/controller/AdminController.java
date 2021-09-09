package com.board.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.admin.model.AdminMaster;
import com.board.admin.service.AdminService;
import com.board.common.model.UserMaster;

@RestController
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@RequestMapping(value = "/adminMain.do")
	public ModelAndView adminHome(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession(true);
		UserMaster userVo = (UserMaster)session.getAttribute("userInfo");
		mv.setViewName("admin/adminMain");
		return mv;
	}

	@RequestMapping(value = "/adminCheck.do")
	public ModelAndView adminCheck(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession(true);
		AdminMaster adminMaster = (AdminMaster)session.getAttribute("adminInfo");
		if (adminMaster.getAuthLevel() == 0) {
			mv.setViewName("admin/adminMain");
		}

		return mv;
	}
}
