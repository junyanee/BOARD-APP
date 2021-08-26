package com.board.common.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;

@RestControllerAdvice
public class ExceptionController {

	@RequestMapping(value = "/error")
	public ModelAndView exceptionMv(HttpServletRequest request, Exception e) {

		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

		ModelAndView mv = new ModelAndView();

		if (status != null) {
			int statusCode = Integer.valueOf(status.toString());

			if (statusCode == HttpStatus.NOT_FOUND.value()) {
				mv.setViewName("/error/404");
				mv.addObject("exception", e);
				return mv;
			}

			if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				mv.setViewName("/error/500");
				mv.addObject("exception", e);
				return mv;
			}
		}
		return null;

}
}