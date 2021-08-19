<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script>
function del(idx) {
	var delCheck = confirm("정말 삭제하시겠습니까?");
	if (delCheck) {
		location.href = '/boardDelete.do?idx=' + idx;
	}
}
</script>
<meta charset="UTF-8">
<title>선택된 게시글</title>
</head>
<body>
	<div class="container">
		<h3>게시글 내용</h3>
		<hr />
		<div class="mb-3">
			<input type="hidden" name="getArticle.idx" value="${getArticle.idx }"></input>
			<label for="getArticle.title" class="form-label">제목</label>
			<div class = "form-control">
				<c:out value = "${getArticle.title }" />
			</div>
		</div>
		<div class="mb-3">
			<label for="getArticle.contents" class="form-label">내용</label>
			<div class="form-control">
				<c:out value="${getArticle.contents }" escapeXml="false" />
			</div>
		</div>
		<div class="float-right">
			<a href="/boardModify.do?idx=${getArticle.idx }"><button type="button" class="btn btn-primary">수정</button></a>
			<button type="button" id = "deleteButton" class="btn btn-primary" onclick = "del(${getArticle.idx})">삭제</button>
			<a href="/board-main.do"><button type="submit" class="btn btn-primary">목록</button></a>
		</div>
		<br /> <br />
		<div>
			<label for = "commentList">댓글</label>
		</div>
		<hr>
		<div>
			<ol>
				<c:forEach items = "${commentList }" var = "commentList">
					<li>
						<input type = "hidden" name = "getComment.idx" value = "${commentList.idx }"></input>
							<div class = "comment">
								<strong id = "getComment.moduser">${commentList.moduser }</strong>
								<small id = "getComment.moddate" class = "float-center">${commentList.moddate }</small>
							</div>
							<div>
								<p id = "getComment.contents">${commentList.contents }</p>
							</div>
					</li>
				</c:forEach>
			</ol>
		</div>
	</div>
</body>
</html>