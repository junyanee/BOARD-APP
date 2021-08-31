<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resources/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<div class="sidenav">
		<div class="login-main-text">
		<img src="/resources/img/logo/logo1.png" alt="삼양데이타시스템 로고"
				width="500">
		</div>

	</div>
	<div class="main">
		<div class="col-md-6 col-sm-12">
			<div class="login-form">
				<form method="post" action="./LoginProc.do">
				<div>
					<h2> 로그인 </h2>
				</div>
					<div class="form-group">
						<label>사번</label> <input type="text" class="form-control"
							placeholder="syc000000" id="userId" name="userId">
					</div>
					<div class="form-group">
						<label>비밀번호</label> <input type="password"
							class="form-control" placeholder="Password" id="userPw" name="userPw">
					</div>
					<button type="submit" class="btn btn-primary float-right">로그인</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>