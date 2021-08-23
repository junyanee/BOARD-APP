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
			<input type = "hidden" name = "getArticle.insuser" value = "${getArticle.insuser }"></input>
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
			<!-- 게시글 등록한 사람에게만 수정, 삭제 버튼 출력 -->
			<c:if test = "${sessionScope.userInfo.empCode == getArticle.insuser }">
				<a href ="/boardModify.do?idx=${getArticle.idx }"><button type ="button" class="btn btn-primary"> 수정 </button></a>
				<button type="button" id = "deleteButton" class="btn btn-primary" onclick = "del(${getArticle.idx})"> 삭제 </button>
			</c:if>
			<a href="/board-main.do"><button type="button" class="btn btn-primary"> 목록 </button></a>
		</div>
		<br /> <br />
		<div>
			<label for = "commentList"> 댓글 </label>
		</div>
		<hr>
		<div>
			<ol>
				<c:forEach items = "${commentList }" var = "commentList" varStatus = "status">
					<li class = "form-control">
						<input type = "hidden" name = "getComment.idx" value = "${commentList.idx }"></input>
							<div>
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