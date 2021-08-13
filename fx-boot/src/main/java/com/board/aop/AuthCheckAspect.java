package com.board.aop;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse.ResponseInfo;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


import com.board.common.service.LoginService;


@Aspect
@Component
public class AuthCheckAspect {
	private final LoginService loginService;

	public AuthCheckAspect(LoginService loginService) {
		this.loginService = loginService;
	}

	@Before("@annotation(com.board.aop.annotation.LoginCheck)")
	public void loginCheck() throws HttpClientErrorException{
		HttpSession session = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest().getSession();
		//String userId = session.getAttribute("userId").toString();
		if(session.getAttribute("userInfo") == null) {
			throw new HttpClientErrorException(HttpStatus.UNAUTHORIZED);
		}
	}
}
