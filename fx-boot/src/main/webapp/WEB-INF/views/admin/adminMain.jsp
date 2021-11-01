<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body>
	<div class = "header-divider"></div>
	<div class = "container" id = "container">
		<h1> 관리자 페이지 </h1>
	</div>

	<div class="container">
        <div class="row">
          <div class="col-md-5 jumbotron">
            <h2>게시글 관리</h2>
            <p>게시판에 등록되어 있는 게시글을 관리할 수 있습니다. </p>
            <p><a class="btn btn-primary float-right" href="/board-main.do" role="button">관리하기 &raquo;</a></p>
          </div>
          <div class="col-md-1">
          </div>
          <div class="col-md-5 jumbotron">
            <h2>배너 설정</h2>
            <p>홈 화면의 배너 이미지, 정보를 변경할 수 있습니다. </p>
            <p><a class="btn btn-primary float-right" href = "/admin/manageBanner.do" role="button">변경하기 &raquo;</a></p>
          </div>
        </div>
        <div class="row">
          <div class="col-md-5 jumbotron">
            <h2>관리자 추가 / 삭제</h2>
            <p>관리자를 추가하거나 삭제할 수 있습니다. </p>
            <p><a class="btn btn-primary float-right" href="/admin/addAdmin.do" role="button">변경하기 &raquo;</a></p>
          </div>
          <div class="col-md-1">
          </div>
          <div class="col-md-5 jumbotron">
            <h2>관리자 권한 설정</h2>
            <p>관리자의 권한을 변경할 수 있습니다. </p>
            <p><a class="btn btn-primary float-right" href = "/admin/modifyAdminInfo.do" role="button">설정하기 &raquo;</a></p>
          </div>
        </div>
	</div>
</body>
</html>