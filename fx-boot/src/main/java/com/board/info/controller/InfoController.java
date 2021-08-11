package com.board.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.aop.annotation.LoginCheck;
import com.board.common.model.ParameterWrapper;
import com.board.model.testMaster;
import com.board.service.InfoService;

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

}
