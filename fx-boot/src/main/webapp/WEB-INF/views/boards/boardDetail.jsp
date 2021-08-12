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
			<label for="exampleFormControlInput1" class="form-label">제목</label>
			<input class="form-control" id="getBoardContents.title"
				name="getBoardContents.title" value="${getArticle.title }" readonly></input>
				<input id="getBoardContents.insUser" name="getBoardContents.insUser" value="${board.insuser }"></input>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">내용</label>
			<input class="form-control" id="getBoardContents.contents"
				name="getBoardContents.contents" value="${getArticle.contents }" readonly></input>
		</div>
		<div class="float-right">
			<button type="submit" class="btn btn-primary">수정</button>
			<button type="submit" class="btn btn-primary">삭제</button>
			<button type="submit" class="btn btn-primary">목록</button>
		</div>
	</div>
</body>
</html>