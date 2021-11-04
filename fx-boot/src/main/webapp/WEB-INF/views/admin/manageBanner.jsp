<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "_csrf" content="${_csrf.token }"/>
<meta name = "_csrf_header" content="${_csrf.headerName }" />
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function (){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function (e, xhr, options){
		xhr.setRequestHeader(header, token);
	})
});

function checkActivate(form) {
	if (form.buttonCheck.checked == true) {
		form.buttonContents.removeAttribute("readonly");
		form.buttonLink.removeAttribute("readonly");
	} else {
		form.buttonContents.setAttribute("readonly", true)
		form.buttonLink.setAttribute("readonly", true)
		form.buttonContents.value = "";
		form.buttonLink.value = "";

	}
}
function updateBannerInfo() {

	result = confirm("저장하시겠습니까??");

	if (result) {
		fng_UploadFile("firstBanner","/admin/updateBannerInfo.do",
				fng_UploadFile("secondBanner","/admin/updateBannerInfo.do",
						fng_UploadFile("thirdBanner","/admin/updateBannerInfo.do", fn_FileUploadResult)));
	}
}
//파일 업로드 결과 callback
function fn_FileUploadResult(result) {
 var string = result;
 var json = JSON.parse(string);
	if(json.isSuccess == true) {
		alert("업데이트가 정상적으로 완료되었습니다.");
		window.location.href = "/admin/adminCheck.do"

	}else if(json.isSuccess == false) {
		alert("업데이트가 실패했습니다.");
		return;
	}
}
</script>
</head>
<body>
<div class = "header-divider"></div>
<div class = "container">
	<h1>배너 관리</h1>
</div>
<div class = "container">
	<p style = "text-align:center;"> 변경하고자 하는 배너 정보를 입력 해주세요.</p>
	<form id = "firstBanner" name = "firstBanner" enctype="multipart/form-data">
		<h5>배너1</h5>
		<input type = "hidden" id = "idx" name = "idx" value = "1" />
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지1</label>
			<input class = "form-control" id = "firstImage" name = "attachImage" type = "file" />
		<div style = "color:red;" class = "form-text">
			<p> * 배너 이미지는 가로 1500픽셀, 세로 550픽셀로 등록해주세요.</p>
		</div>
		<div>
			<label for = "title" class = "form-label">제목</label>
			<input class = "form-control" id = "title" name = "title" type = "text" />

			<label for = "contents" class = "form-label">내용</label>
			<input class = "form-control" id = "contents" name = "contents" type = "text" />
		</div>
		<div>
			<div>
				<label for = "checkbox">버튼 생성</label>
				<input type = "checkbox" id = "buttonCheck" name = "buttonCheck" onclick = "checkActivate(this.form)"/>
			</div>
			<br>
			<div class = "container">
				<label for = "buttonContents" class = "form-label">버튼 내용</label>
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" readonly />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" readonly />
			</div>
		</div>
		</div>
	</form>
	<hr />
		<form id = "secondBanner" name = "secondBanner" enctype="multipart/form-data">
		<h5>배너2</h5>
		<input type = "hidden" id = "idx" name = "idx" value = "2" />
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지2</label>
			<input class = "form-control" id = "secondImage" name = "attachImage" type = "file" />
		<div style = "color:red;" class = "form-text">
			<p> * 배너 이미지는 가로 1500픽셀, 세로 550픽셀로 등록해주세요.</p>
		</div>
		<div>
			<label for = "title" class = "form-label">제목</label>
			<input class = "form-control" id = "title" name = "title" type = "text" />

			<label for = "contents" class = "form-label">내용</label>
			<input class = "form-control" id = "contents" name = "contents" type = "text" />
		</div>
		<div>
			<div>
				<label for = "checkbox">버튼 생성</label>
				<input type = "checkbox" id = "buttonCheck" name = "buttonCheck" onclick = "checkActivate(this.form)"/>
			</div>
			<br>
			<div class = "container">
				<label for = "buttonContents" class = "form-label">버튼 내용</label>
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" readonly />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" readonly />
			</div>
		</div>
		</div>
	</form>
	<hr />
		<form id = "thirdBanner" name = "thirdBanner" enctype="multipart/form-data">
		<h5>배너3</h5>
		<input type = "hidden" id = "idx" name = "idx" value = "3" />
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지3</label>
			<input class = "form-control" id = "thirdImage" name = "attachImage" type = "file" />
		<div style = "color:red;" class = "form-text">
			<p> * 배너 이미지는 가로 1500픽셀, 세로 550픽셀로 등록해주세요.</p>
		</div>
		<div>
			<label for = "title" class = "form-label">제목</label>
			<input class = "form-control" id = "title" name = "title" type = "text" />

			<label for = "contents" class = "form-label">내용</label>
			<input class = "form-control" id = "contents" name = "contents" type = "text" />
		</div>
		<div>
			<div>
				<label for = "checkbox">버튼 생성</label>
				<input type = "checkbox" id = "buttonCheck" name = "buttonCheck" onclick = "checkActivate(this.form)"/>
			</div>
			<br>
			<div class = "container">
				<label for = "buttonContents" class = "form-label">버튼 내용</label>
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" readonly />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" readonly />
			</div>
		</div>
		</div>
	</form>
	<hr />
	<div style = "margin-bottom: 100px; padding-bottom:50px;">
		<button class = "btn btn-primary float-right" type = "button" onclick = "updateBannerInfo()">저장</button>
	</div>
</div>
</body>
</html>