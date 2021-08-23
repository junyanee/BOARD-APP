<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script type="text/javascript">
$(document).ready(function (){
	// SmartEditor2 사용 선언
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "modifyArticle.contents",
	 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});

	$('#saveButton').click(function() {
		oEditors.getById['modifyArticle.contents'].exec("UPDATE_CONTENTS_FIELD", []);
		var title = document.getElementById('modifyArticle.title').value;
		var contents = document.getElementById('modifyArticle.contents').value;
		// 제목 Validation Check
		if(title == null || title == "") {
			alert("제목을 입력해주세요.");
			document.getElementById('modifyArticle.title').focus();
			return;
		}
		// 내용 Validation Check
		if (contents == null || contents == "" || contents == '&nbsp;' || contents == '<p>&nbsp;</p>' ||
			contents == '<br>' || contents == '<br/>' || contents == '<p><br></p>') {
			alert("내용을 입력해주세요.");
			oEditors.getById['modifyArticle.contents'].exec("FOCUS");
			return;
		}
		// 게시글 저장 (form 전송)
		var result = confirm("저장하시겠습니까");
		if(result) {
			alert("저장완료");
			document.getElementById('frm').submit();
		} else {
			return;
		}
	});
});
</script>
</head>

<body>
	<div class = "container">
		<h3>게시글 수정</h3>
		<hr />
		<form method="POST" id="frm" name="frm">
			<div class="mb-3">
				<label for="exampleFormControlInput1" class="form-label">제목</label>
				<input type="text" class="form-control" id="modifyArticle.title"
					name="modifyArticle.title" value = "${modifyArticle.title }">
			</div>
			<div class="mb-3">
				<label for="exampleFormControlTextarea1" class="form-label">내용</label>
				<textarea class="form-control" name="modifyArticle.contents"
					id="modifyArticle.contents" rows="15" cols="200">${modifyArticle.contents }</textarea>
			</div>
			<div class="mb-3">
				<label for="formFileMultiple" class="form-label">파일 업로드</label> <input
					class="form-control" type="file" id="formFileMultiple" multiple>
			</div>
			<div class = "float-right">
			<button class="btn btn-primary" type="button" id="saveButton">수정하기</button>
			<button class="btn btn-primary" type="button" id="resetButton">리셋하기</button>
			</div>
		</form>
	</div>
</body>
</html>
