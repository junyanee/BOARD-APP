<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
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
  <textarea class="form-control" id="newArticle.contents" name ="newArticle.contents" rows="10"></textarea>
</div>
<div class="mb-3">
  <label for="formFileMultiple" class="form-label">파일 업로드</label>
  <input class="form-control" type="file" id="formFileMultiple" multiple>
</div>
  <button type="submit" class="btn btn-primary float-right">올리기</button>
</form>
</body>
</html>