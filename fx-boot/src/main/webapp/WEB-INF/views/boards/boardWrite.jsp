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
	 elPlaceHolder: "ir1",
	 sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	 fCreator: "createSEditor2"
	});
});

</script>
</head>

<body>
<h3> 새 게시글 작성</h3>
<hr />
<form method="POST">
  <div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">제목</label>
  <input type="text" class="form-control" id="newArticle.title" name = "newArticle.title" placeholder="제목을 입력하세요.">
</div>
<div class="mb-3">
<label for="exampleFormControlTextarea1" class="form-label">내용</label>
<!-- <textarea class="form-control" id="newArticle.contents" name ="newArticle.contents" rows="10"></textarea> -->
<textarea class="form-control" name="newArticle.contents" id="ir1" rows="15" cols="200">에디터에 기본으로 삽입할 글(수정 모드)이 없다면 이 value 값을 지정하지 않으시면 됩니다.</textarea>
</div>
<div class="mb-3">
  <label for="formFileMultiple" class="form-label">파일 업로드</label>
  <input class="form-control" type="file" id="formFileMultiple" multiple>
</div>
  <button type="submit" class="btn btn-primary float-right">올리기</button>
</form>

</body>
</html>
