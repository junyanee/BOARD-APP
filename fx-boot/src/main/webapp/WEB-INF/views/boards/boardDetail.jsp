<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<div>
			<c:out value = "${getArticle.contents }" escapeXml = "false" />
			</div>
		</div>
		<div class="float-right">
			<a href="http://localhost:8080/boardModify.do?idx=${getArticle.idx }"><button type="submit" class="btn btn-primary">수정</button></a>
			<a href="http://localhost:8080/boardDelete.do?idx=${getArticle.idx }"><button type="submit" class="btn btn-primary">삭제</button></a>
			<a href="http://localhost:8080/board-main.do"><button type="submit" class="btn btn-primary">목록</button></a>
		</div>
	</div>
</body>
</html>