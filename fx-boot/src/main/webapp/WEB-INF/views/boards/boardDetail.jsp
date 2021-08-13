<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택된 게시글</title>
</head>
<body>
	<div class="container">
		<h3>게시글 내용</h3>
		<hr />
		<div class="mb-3">
		<input type = "hidden" name="getArticle.idx" value="${getArticle.idx }"></input>
			<label for="getArticle.title" class="form-label">제목</label>
			<input type = "text" class="form-control" id="getBoardContents.title"
				name="getArticle.title" value="${getArticle.title }" readonly></input>
		</div>
		<div class="mb-3">
			<label for="getArticle.contents" class="form-label">내용</label>
			<input type = "text" class="form-control" id="getBoardContents.contents"
				name="getBoardContents.contents" value="${getArticle.contents }" readonly></input>
		</div>
		<div class="float-right">
			<button type="submit" class="btn btn-primary">수정</button>
			<button type="submit" class="btn btn-primary">삭제</button>
			<a href="http://localhost:8080/board-main.do"><button type="submit" class="btn btn-primary">목록</button></a>
		</div>
	</div>
</body>
</html>