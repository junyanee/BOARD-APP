package com.board.aop;

import java.util.Enumeration;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.Joinable;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
@Aspect
public class LoggerAspect {
/*Logger AOP*/

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Around("within(com.board..*)")
	public Object printLog(ProceedingJoinPoint joinPoint) throws Throwable {

		HttpServletRequest request = null;

		String paramString = "";
		paramString = getRequestParameters(request);
        long startAt = System.currentTimeMillis();
		logger.info("----------> REQUEST : {}({}) = {}", joinPoint.getSignature().getDeclaringTypeName(),
		joinPoint.getSignature().getName(), paramString);
        Object result = joinPoint.proceed();
        long endAt = System.currentTimeMillis();
        logger.info("----------> RESPONSE : {}({}) = {} ({}ms)", joinPoint.getSignature().getDeclaringTypeName(),
        		joinPoint.getSignature().getName(), result, endAt-startAt);
        return result;
	}

	private String getRequestParameters(HttpServletRequest request) {
		StringBuffer paramBuf = new StringBuffer();

		if(RequestContextHolder.getRequestAttributes() != null) {

			request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

			Enumeration<String> paramNames = request.getParameterNames();

			while (paramNames.hasMoreElements()) {
				String paramName = (String) paramNames.nextElement();
				if(paramBuf.indexOf("?") > -1) {
					paramBuf.append("&" + paramName + "=" + request.getParameter(paramName));
				}
				else {
					paramBuf.append("?" + paramName + "=" + request.getParameter(paramName));
				}
			}
			return paramBuf.toString();
		}else {

			return "nonParams";
		}

	}

}
