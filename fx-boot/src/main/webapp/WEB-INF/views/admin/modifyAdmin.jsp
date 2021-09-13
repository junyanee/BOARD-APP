<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class = "container">
		<br />
		<h1> 관리자 권한 설정</h1>
		<hr />
		<div class = "float-right">
			<button type="button" class="btn btn-primary" id = "setAdmin" name = "setAdmin">설정</button>
			<button type="button" class="btn btn-primary" id = "deleteAdmin" name = "deleteAdmin">삭제</button>
		</div>
		<br />
		<br />
		<div>
		<c:import url="/admin/setAdmin.do" />

		</div>
	</div>
</body>
</html>