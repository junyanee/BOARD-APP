<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>404</title>
</head>
<body>
<div class = "header-divider"></div>
<div class="page-wrap d-flex flex-row align-items-center" style = ".page-wrap {min-height: 100vh;}">
    <div class="container" id = "container">
        <div class="row justify-content-center">
            <div class="col-md-12 text-center">
            	<img src = "/resources/img/common/not-found.png" width = "200" height = "200">
                <span class="display-1 d-block">404</span>
                	<div class="mb-4 lead">
                		페이지를 찾을 수 없습니다. URL을 다시 확인해 주세요.
                	</div>
                <a href="/home.do" class="btn btn-link">홈으로 돌아가기</a>
            </div>
        </div>
        <div>
        	<h3> ${exception.getMessage() }</h3>
        	<ul>
        		<c:forEach items = "${exception.getStackTrace() }" var = "stack">
        			<li> ${stack.toString() } </li>
        		</c:forEach>
        	</ul>
        </div>
    </div>
</div>
</body>
</html>