package com.board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping(value="/")
public class BoardController {
	@RequestMapping(value = "/home.do")
	public ModelAndView home(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();

		mv.setViewName("main/home");
		return mv;
	}
}
