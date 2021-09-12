package com.board.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.admin.model.AdminMaster;
import com.board.admin.service.AdminService;
import com.board.common.model.UserMaster;
import com.board.common.service.UserMasterService;
import com.board.utility.Search;

@RestController
@RequestMapping(value = "/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	@Autowired
	UserMasterService userMasterService;

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

	@RequestMapping(value = "/addAdmin.do")
	public ModelAndView addAdmin(HttpServletRequest request,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "empName") String searchType,
			@RequestParam(required = false) String keyword, @ModelAttribute("search") Search search) throws Exception {
		ModelAndView mv = new ModelAndView();

		// Search
		mv.addObject("search", search);
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		// Pagination
		int listCnt = userMasterService.getUserListCnt(search);
		search.pageInfo(page, range, listCnt);
		List<UserMaster> userList = userMasterService.getAllUser(search);
		mv.addObject("pagination", search);
		mv.addObject("userList", userList);
		mv.setViewName("admin/addAdmin");
		return mv;
	}
}
