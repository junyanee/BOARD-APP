<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 게시판</title>
</head>
<body>
	<div class="container">
		<h2>메인 게시판</h2>
		<hr>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>댓글수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="boardList" items="${boardList}" varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td>${boardList.title }</td>
						<td>${boardList.insuser }</td>
						<td>${boardList.insdate }</td>
						<td>${boardList.read_cnt }</td>
						<td>${boardList.comment_cnt }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<hr />
		<a class="btn btn-dark">글쓰기</a>

		<div class="text-center">
			<ul class="pagination justify-content-center">
				<li class="page-item"><a class="page-link" href="#">이전</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item"><a class="page-link" href="#">다음</a></li>
			</ul>
		</div>
	</div>
</body>
</html>