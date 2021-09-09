<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="No-Cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0" />
<%@ include file="/resources/common/headerTag.jspf"%>
</head>
<body>
     <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
      <a class="navbar-brand" href="/home.do">SYDS Boards</a>

      <div class="collapse navbar-collapse" id="navbarsExample04">
        <ul class="navbar-nav mr-auto">
           <li class="nav-item active">
            <a class="nav-link" href="/board-main.do">게시판 <span class="sr-only">(current)</span></a>
          </li>
          <c:if test = "${sessionScope.userInfo != null }">
          <li class="nav-item active">
            <a class="nav-link" href="/Login/Login.do">로그아웃</a>
          </li>
          </c:if>
        </ul>
			<c:choose>
        	     	<c:when test ="${sessionScope.userInfo != null}">
						<c:choose>
        	     			<c:when test="${sessionScope.adminInfo != null }">
        	     				<div>
        	     					<span class = "navbar-text">
        	     						${adminInfo.adminName } 관리자님
        	     					</span>
        	     					<a href = "#">
        	     						<img src ="/resources/img/common/ic_micro_setting.png" alt = "관리" />
        	     					</a>
        	     				</div>
        	     			</c:when>
        	     			<c:otherwise>
        	     				<span class = "navbar-text">
        	     					${userInfo.empName } ${userInfo.empTypeName }님
        	     				</span>
        	     			</c:otherwise>
        	     		</c:choose>
        	     	</c:when>
        	</c:choose>
      </div>
    </nav>
</body>
</html>