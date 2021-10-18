package com.board.common.controller;

import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.board.model.BoardMaster;
import com.board.common.model.BannerMaster;
import com.board.common.model.ItemMaster;
import com.board.common.model.ParameterWrapper;
import com.board.common.model.PersonDTO;
import com.board.common.service.CommonService;

@RestController
@RequestMapping(value="/Common")
public class CommonController {

	@Autowired
	CommonService service;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/getItemCode.do")
	public List<ItemMaster> getItemCode(HttpServletRequest request, @RequestBody ParameterWrapper<ItemMaster> param) throws Exception {
		logger.debug("=============getItemCode Call =============");
		logger.debug("=============getItemCode Call =============");
		return service.getItemCode(param.param);
	}

	// home 진입
	@RequestMapping(value = "/home.do")
	public ModelAndView mainHome(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<BannerMaster>bannerInfo = service.getBannerInfo();
		mv.addObject("bannerInfo", bannerInfo);
		mv.setViewName("main/home");
		return mv;
	}

	// 이름, 나이 입력 페이지
	@RequestMapping(value = "/insertHome.do")
	public ModelAndView insertHome(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("info/home");
		return mv;
	}

	// 제출 눌렀을때 DB에 insert 하는 함수 (ajax 통신)
	@RequestMapping(value = "/insertTest.do", method = RequestMethod.POST)
	public String insertTest(HttpServletRequest request, @RequestBody PersonDTO personDto) throws Exception {
		String ajaxResult = "";
		service.insertPerson(personDto);
		return ajaxResult;
	}

	// 결과 확인 페이지
	@RequestMapping(value = "/insertResult.do")
	public ModelAndView insertResult(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<PersonDTO> personList = service.getPersonList();
		mv.addObject("personList", personList);
		mv.setViewName("info/result");
		return mv;
	}
}

