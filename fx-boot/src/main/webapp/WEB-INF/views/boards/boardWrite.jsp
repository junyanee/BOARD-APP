<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
<script type="text/javascript">
$(document).ready(function (){
	// SmartEditor2 사용 선언
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "newArticle.contents",
	 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});

	$('#saveButton').click(function() {
		oEditors.getById['newArticle.contents'].exec("UPDATE_CONTENTS_FIELD", []);
		var title = document.getElementById('newArticle.title').value;
		var contents = document.getElementById('newArticle.contents').value;
		// 제목 Validation Check
		if(title == null || title == "") {
			alert("제목을 입력해주세요.");
			document.getElementById('newArticle.title').focus();
			return;
		}
		// 내용 Validation Check
		if (contents == null || contents == "" || contents == '&nbsp;' || contents == '<p>&nbsp;</p>' ||
			contents == '<br>' || contents == '<br/>' || contents == '<p><br></p>') {
			alert("내용을 입력해주세요.");
			oEditors.getById['newArticle.contents'].exec("FOCUS");
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
	<h3>새 게시글 작성</h3>
	<hr />
	<form method="POST" id="frm" name="frm" enctype = "multipart/form-data">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">제목</label> <input
				type="text" class="form-control" id="newArticle.title"
				name="newArticle.title" placeholder="제목을 입력하세요.">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label"> 내용</label>
			<textarea class="form-control" name="newArticle.contents"
				id="newArticle.contents" rows="15" cols="200"></textarea>
		</div>
		<div class="mb-3">
			<label for="formFileMultiple" class="form-label">파일 업로드</label>
			<input class="form-control fileUpload" type="file" id="formFileMultiple" name = "uploadFile" multiple = "multiple">
		</div>
		<button class="btn btn-primary" type="button" id="saveButton">글쓰기</button>
	</form>
</div>
</body>
</html>
