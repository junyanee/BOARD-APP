<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function checkActivate(form) {
	if (form.buttonCheck.checked == true) {
		form.buttonContents.disabled = false;
		form.buttonLink.disabled = false;
	} else {
		form.buttonContents.value = "";
		form.buttonLink.value = "";
		form.buttonContents.disabled = true;
		form.buttonLink.disabled = true;
	}
}
function updateBannerInfo() {
	// var first = $('#firstBanner').serializeObject();
	var form = new FormData();
	form.append("imageSrc", $('#imageSrc')[0].files[0]);
	var param1 = new FormData($('#firstBanner')[0]);

	var bannerAjaxOptions = {
			SvcName: "/admin",
			MethodName: "updateBannerInfo.do",
			data: form,
			enctype:"multipart/form-data",
			processData: false,
			contentType: false,
			async: false,
			Callback: function() {
				alert("성공");
			},
			ErrorCallback: function() {
				alert("실패");
			}
	};
	$.fng_Ajax(bannerAjaxOptions);

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
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지1</label>
			<input class = "form-control" id = "imageSrc" name = "imageSrc1" type = "file" />
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
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" disabled />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" disabled />
			</div>
		</div>
		</div>
	</form>
	<hr />
		<form id = "secondBanner" name = "secondBanner" enctype="multipart/form-data">
		<h5>배너2</h5>
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지2</label>
			<input class = "form-control" id = "imageSrc" name = "imageSrc2" type = "file" />
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
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" disabled />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" disabled />
			</div>
		</div>
		</div>
	</form>
	<hr />
		<form id = "thirdBanner" name = "thirdBanner" enctype="multipart/form-data">
		<h5>배너3</h5>
		<div style = "border: solid 1px; padding : 15px;">
			<label for = "imageSrc" class = "form-label">배너 이미지3</label>
			<input class = "form-control" id = "imageSrc" name = "imageSrc3" type = "file" />
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
				<input class = "form-control" id = "buttonContents" name = "buttonContents" type = "text" disabled />
				<br>
				<label for = "buttonLink" class = "form-label">버튼 링크(URL)</label>
				<input class = "form-control" id = "buttonLink" name = "buttonLink" type = "text" disabled />
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