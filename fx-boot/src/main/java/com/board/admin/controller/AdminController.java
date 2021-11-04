package com.board.admin.controller;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.board.admin.model.AdminMaster;
import com.board.admin.service.AdminService;
import com.board.aop.annotation.LoginCheck;
import com.board.common.model.BannerMaster;
import com.board.common.model.ParameterWrapper;
import com.board.common.model.ParameterWrapper3;
import com.board.common.model.UserMaster;
import com.board.common.service.UserMasterService;
import com.board.utility.ScriptUtils;
import com.board.utility.Search;
import com.fasterxml.jackson.databind.ObjectMapper;

import jdk.javadoc.internal.doclets.formats.html.markup.Script;

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
	public ModelAndView adminCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();

		HttpSession session = request.getSession(true);
		AdminMaster adminMaster = (AdminMaster)session.getAttribute("adminInfo");
		if (adminMaster.getAuthLevel() <= 2) {
			mv.setViewName("redirect:/admin/adminMain.do");
		} else {
			ScriptUtils.alert(response, "정상적이지 않은 접근입니다. 홈으로 돌아갑니다.");
			mv.setViewName("redirect:/Common/home.do");
		}

		return mv;
	}

	@RequestMapping(value = "/modifyAdmin.do")
	public ModelAndView modifyAdmin(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("admin/modifyAdmin");
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
		search.setListSize(5); // 한 페이지당 보여질 리스트 개수
		search.setRangeSize(5); // 한 페이지 범위에 보여질 페이지의 개수
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

	@RequestMapping(value = "/modifyAdminInfo.do")
	public ModelAndView modifyAdminInfo(HttpServletRequest request,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "adminName") String searchType,
			@RequestParam(required = false) String keyword, @ModelAttribute("search") Search search) throws Exception {
		ModelAndView mv = new ModelAndView();

		// Search
		mv.addObject("search", search);
		search.setListSize(5); // 한 페이지당 보여질 리스트 개수
		search.setRangeSize(5); // 한 페이지 범위에 보여질 페이지의 개수
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		// Pagination
		int listCnt = adminService.getAdminListCnt(search);
		search.pageInfo(page, range, listCnt);
		List<AdminMaster> adminList = adminService.getAdminUser(search);
		mv.addObject("pagination", search);
		mv.addObject("adminList", adminList);
		mv.setViewName("admin/modifyAdminInfo");
		return mv;
	}

	@RequestMapping(value = "/modifyAuthLevel.do", method = RequestMethod.POST)
	public String modifyAuthLevel(HttpServletRequest request, @RequestBody Map<String,Object> param) throws Exception {
		String ajaxResult = "";
		HttpSession session = request.getSession();
		AdminMaster adminInfo = (AdminMaster) session.getAttribute("adminInfo");

		AdminMaster adminMaster = new AdminMaster();
		adminMaster.setAdminCode(Integer.parseInt((String) param.get("param1")));
		adminMaster.setAuthLevel(Integer.parseInt((String) param.get("param2")));

		AdminMaster selectedUserInfo = adminService.getAdminInfoByAdminCode(adminMaster.getAdminCode());
		int currentUserAuth = adminInfo.getAuthLevel();

		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (currentUserAuth < selectedUserInfo.getAuthLevel()) {
			resultMap = adminService.modifyAuthLevel(adminMaster);
		} else {
			resultMap.put("isSuccess", false);
			resultMap.put("resultMsg", "상위 권한은 수정할 수 없습니다.");
		}

		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}


	@RequestMapping(value = "/setAdmin.do", method = RequestMethod.POST)
	public String setAdmin(HttpServletRequest request, @RequestBody Map<String,Object> param) throws Exception {
		String ajaxResult = "";
		UserMaster userMaster = new UserMaster();
		userMaster.setEmpCode((String) param.get("param1"));
		String userType = (String) param.get("param2");
		if(userType.equals("일반")) {
			userMaster.setIsAdmin(2);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userMasterService.setAdmin(userMaster);

		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}


	@RequestMapping(value = "/deleteAdmin.do", method = RequestMethod.POST)
	public String deleteAdmin(HttpServletRequest request, @RequestBody Map<String,Object> param) throws Exception {
		String ajaxResult = "";
		UserMaster userMaster = new UserMaster();
		userMaster.setEmpCode((String) param.get("param1"));
		String userType = (String) param.get("param2");
		userType = userType.trim();
		if (userType.equals("관리자") || userType.equals("매니저")) {
			userMaster.setIsAdmin(3);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = userMasterService.deleteAdmin(userMaster);

		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}

	@RequestMapping(value = "/manageBanner.do")
	public ModelAndView manageBanner(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("admin/manageBanner");
		return mv;
	}

	@RequestMapping(value = "/updateBannerInfo.do")
	public String updateBannerInfo(HttpServletRequest request, BannerMaster param) throws Exception {
		MultipartHttpServletRequest msr = (MultipartHttpServletRequest) request;
		MultipartFile file = msr.getFile("attachImage");
		if(!file.isEmpty()) {
			String imageSrc = "/resources/img/common/" + file.getOriginalFilename();
			String imagePath = msr.getSession().getServletContext().getRealPath(imageSrc);
			param.setImageSrc(imageSrc);
			Path filePath = Paths.get(imagePath);
			try {
				file.transferTo(filePath);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			String imageSrc = "/resources/img/common/slide-01.jpg";
			param.setImageSrc(imageSrc);
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = adminService.updateBannerInfo(param);
		String ajaxResult = "";

		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}
}
