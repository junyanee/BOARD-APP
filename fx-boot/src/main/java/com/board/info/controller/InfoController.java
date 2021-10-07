package com.board.info.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.board.model.BoardMaster;
import com.board.board.model.FileMaster;
import com.board.common.model.ParameterWrapper;
import com.board.common.model.UserMaster;
import com.board.info.model.testMaster;
import com.board.info.service.InfoService;
import com.board.utility.Search;
import com.fasterxml.jackson.databind.ObjectMapper;

import sun.nio.ch.IOUtil;

@RestController
@RequestMapping(value="/Info")
public class InfoController {

	@Autowired
	InfoService service;

	@Value("${custom.config.upload.profile-image.path}")
	private String path;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@RequestMapping(value = "/home.do")
	public ModelAndView home(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("info/home");
		return mv;
	}
	@LoginCheck
	@RequestMapping(value = "/getDataListJson.do")
	public List<testMaster> getDataListJson(HttpServletRequest request, @RequestBody ParameterWrapper<testMaster> param) throws Exception {
		logger.debug(param.param.getTestA());
		return service.getTestData(param.param);
	}

	@RequestMapping(value = "/myPage.do")
	public ModelAndView myPage(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		ModelAndView mv = new ModelAndView();

		List<BoardMaster> myBoardList = service.getMyBoardList(userMaster.getEmpCode());
		mv.addObject("myBoardList", myBoardList);
		mv.setViewName("info/myPage");
		return mv;
	}

	@RequestMapping(value = "/getMyBoardListAll.do")
	public ModelAndView getMyBoardListAll(HttpServletRequest request,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String keyword, @ModelAttribute("search") Search search) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");

		// Search
		mv.addObject("search", search);
		search.setListSize(10); // 한 페이지당 보여질 리스트 개수
		search.setRangeSize(5); // 한 페이지 범위에 보여질 페이지의 개수
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		search.setEmpCode(userMaster.getEmpCode());
		// Pagination
		int listCnt = service.getMyBoardListCnt(search);

		search.pageInfo(page, range, listCnt);
		List<BoardMaster> myBoardList = service.getMyBoardListAll(search);
		mv.addObject("pagination", search);
		mv.addObject("myBoardList", myBoardList);
		mv.setViewName("info/myBoardListAll");
		return mv;
	}

	@RequestMapping(value = "/downloadProfile.do")
	public void downloadProfileImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");

		File userProfileImage = new File(userMaster.getProfileImagePath());
		FileInputStream fileInputStream = new FileInputStream(userProfileImage);
		byte[] imageBytes = IOUtils.toByteArray(fileInputStream);
		response.setContentType("application/x-msdownload");
		response.setContentLength(imageBytes.length);
		response.addHeader("Content-Disposition",
				"attachment;filename=\"" + URLEncoder.encode(userProfileImage.getName(), "UTF-8") + "\";");
		response.getOutputStream().write(imageBytes);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@RequestMapping(value = "/saveProfileImage.do")
	public String saveProfileImage(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		MultipartHttpServletRequest msr = (MultipartHttpServletRequest) request;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String ajaxResult = "";

		MultipartFile file = msr.getFile("inputProfileImage");
		if(!file.isEmpty()) {
			String empCode = userMaster.getEmpCode();
			String fileName = file.getOriginalFilename(); //라이언.jpeg
			int idx = fileName.indexOf(".");
			String extension = fileName.substring(idx);
			String uploadPath = path + "\\" + empCode + extension;
			try {
				file.transferTo(new File(uploadPath));
				service.saveProfileImage(userMaster.getEmpCode(), uploadPath);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}

	@RequestMapping(value = "/saveProfileInfo.do")
	public String saveProfileInfo(HttpServletRequest request, @RequestBody ParameterWrapper<UserMaster> param) throws Exception {
		HttpSession session = request.getSession(false);
		UserMaster userMaster = (UserMaster) session.getAttribute("userInfo");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String ajaxResult = "";

		param.param.setEmpCode(userMaster.getEmpCode());
		String fullEmail = param.param.getEmail();
		if (fullEmail.contains("@samyang.com")) {
			int idx = fullEmail.indexOf("@");
			String emailId = fullEmail.substring(0, idx);
			param.param.setEmail(emailId);
		}

		resultMap = service.saveProfileInfo(param.param);

		ObjectMapper mapper = new ObjectMapper();
		ajaxResult = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(resultMap);
		return ajaxResult;
	}

}
