package com.board.common.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebErrorController implements ErrorController {

	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return null;
	}

	@GetMapping("/error")
	public String handleError(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

		if(status != null) {
			int statusCode = Integer.valueOf(status.toString());

			if(statusCode == HttpStatus.NOT_FOUND.value() || statusCode == HttpStatus.FORBIDDEN.value()) {
				return "error/404";
			} else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()){
				return "error/500";
			} else {
				return "error/error";
			}
		}
		return "error/error";
	}
}