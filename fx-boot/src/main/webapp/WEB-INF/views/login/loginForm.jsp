<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resources/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "_csrf" content="${_csrf.token }"/>
<meta name = "_csrf_header" content="${_csrf.headerName }" />
<title>Login</title>
<script type = text/javascript>
$(document).ready(function() {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function (e, xhr, options){
		xhr.setRequestHeader(header, token);
	})
});
function login() {
	var param;
	param = $(loginForm).serializeObject();

	var loginAjaxOptions = {
			SvcName: "/Login",
			MethodName: "LoginProc.do",
			Params: param,
			async: false,
			Callback: function(response) {
				if(response.loginCheck == true) {
	    			var url = "/home.do";
	        		location.href = url;
				} else if (response.loginCheck == false) {
					alert("로그인 정보를 다시 확인해주세요.");
					$('#userId').val('');
					$('#userPw').val('');
					$('#userId').focus();
					return;
				}
			},
			ErrorCallback: function() {
				alert("로그인에 실패했습니다. 다시 시도해주세요.");
				return;
			}
	};
		$.fng_Ajax(loginAjaxOptions);
}

function enterKey() {
	if (window.event.keyCode == 13) {
		login();
	}
}
</script>
</head>
<body>
	<div class="sidenav">
		<div class="login-main-text" style = "padding-top: 350px">
		<img src="/resources/img/logo/logo1.png" alt="삼양데이타시스템 로고"
				width="500">
		</div>

	</div>
	<div class="main">
		<div class="col-md-6 col-sm-12">
			<div class="login-form" >
				<form method="POST" action="./LoginProc.do" name = "loginForm" id = "loginForm">
				<div>
					<h2> 로그인 </h2>
				</div>
					<div class="form-group">
						<label>사번</label> <input type="text" class="form-control"
							placeholder="syc000000" id="userId" name="userId">
					</div>
					<div class="form-group">
						<label>비밀번호</label> <input type="password"
							class="form-control" placeholder="Password" id="userPw" name="userPw" onkeyup = "javascript:enterKey();">
					</div>
					<button type="button" class="btn btn-primary float-right" onclick = "javascript:login();">로그인</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>