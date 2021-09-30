package com.board.info.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.board.model.BoardMaster;
import com.board.common.model.ParameterWrapper;
import com.board.common.model.UserMaster;
import com.board.info.model.testMaster;
import com.board.info.service.InfoService;
import com.board.utility.Search;

@RestController
@RequestMapping(value="/Info")
public class InfoController {

	@Autowired
	InfoService service;

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

}
