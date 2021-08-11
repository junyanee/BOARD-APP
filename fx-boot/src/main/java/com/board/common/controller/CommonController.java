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
import org.springframework.web.bind.annotation.RestController;

import com.board.board.model.BoardMaster;
import com.board.common.model.ItemMaster;
import com.board.common.model.ParameterWrapper;
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


}

