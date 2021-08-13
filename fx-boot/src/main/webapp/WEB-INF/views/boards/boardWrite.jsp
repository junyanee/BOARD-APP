<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
<script type="text/javascript">
$(document).ready(function (){
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	 oAppRef: oEditors,
	 elPlaceHolder: "newArticle.contents",
	 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
});
/*$(document).ready(function() {
	$("#saveButton").click(function() {
			alert("저장 완료");
		/*
		oEditors.getById["newArticle.contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var title = $("#newArticle.title").val();
		var content = document.getElementById("newArticle.contents").value();
		if (title == null || title == "") {
			alert("제목을 입력해주세요.");
			$("#title").focus();
			return;
			}
		if(content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br/>' || content == '<p>&nbsp;</p>'){
			alert("본문을 작성해주세요.");
			oEditors.getById["newArticle.contents"].exec("FOCUS");
			return;
			}

			var result = confirm("저장 하시겠습니까?");
			if(result){
				alert("저장 완료!");
				$("#frm").submit();
				}else{
					return;
					}

			});

});
*/
</script>
</head>

<body>
	<h3>새 게시글 작성</h3>
	<hr />
	<form method="POST" id="frm" name="frm">
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">제목</label> <input
				type="text" class="form-control" id="newArticle.title"
				name="newArticle.title" placeholder="제목을 입력하세요.">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">내용</label>
			<!-- <textarea class="form-control" id="newArticle.contents" name ="newArticle.contents" rows="10"></textarea> -->
			<textarea class="form-control" name="newArticle.contents"
				id="newArticle.contents" rows="15" cols="200"></textarea>
		</div>
		<div class="mb-3">
			<label for="formFileMultiple" class="form-label">파일 업로드</label> <input
				class="form-control" type="file" id="formFileMultiple" multiple>
		</div>
		<button class="btn btn-primary" type="submit" id="saveButton">글쓰기</button>
	</form>
</body>
</html>

<script type="text/javascript">
#("saveButton").click(function() {
	alert("saveButton clicked");
	oEditors.getById["newArticle.contents"].exec("UPDATE_CONTENTS_FIELD", []);
try {
	alert("저장완료");
	$("#frm").submit();
	} catch (e) {}
});</script>
