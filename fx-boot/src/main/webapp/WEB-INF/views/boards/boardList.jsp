<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
// 이전 버튼
function fn_prev(page, range, rangeSize, searchType, keyword) {
	var page = ((range - 2) * rangeSize) + 1;
	var range = range - 1;

	var url = "${pageContext.request.contextPath}/board-main.do"
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}

// 페이지 번호 클릭
function fn_pagination(page, range, rangeSize, searchType, keyword) {
	var url = "${pageContext.request.contextPath}/board-main.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}

// 다음 버튼
function fn_next(page, range, rangeSize, searchType, keyword) {
	var page = parseInt((range * rangeSize)) + 1;
	var range = parseInt(range) + 1;

	var url = "${pageContext.request.contextPath}/board-main.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}
// 검색 버튼
$(document).on('click', '#btnSearch', function(e) {
	e.preventDefault();
	var url = "${pageContext.request.contextPath}/board-main.do";
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	location.href = encodeURI(url);
	console.log(url);
})
</script>
<meta charset="UTF-8">
<title>메인 게시판</title>
</head>
<body>
	<div class="container">
		<h2>메인 게시판</h2>
		<hr>
		<div class="table-responsive-md">
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope="col">#</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
						<th scope="col">댓글수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="boardList" items="${boardList}" varStatus="status">
						<tr>
							<th scope="row"><c:out value="${status.count }" /></th>
							<td> <a href="/boardDetail.do?idx=${boardList.idx}"><c:out value="${boardList.title }" /> </a> </td>
							<td><c:out value="${boardList.insuser }" /></td>
							<td><c:out value="${boardList.insdate }" /></td>
							<td><c:out value="${boardList.readCnt }" /></td>
							<td><c:out value="${boardList.commentCnt }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<a href="/boardWrite.do"><button type = "button" class="btn btn-dark float-right">글쓰기</button></a>
		</div>
			<br>
			<hr>
		<!-- Pagination -->
		<div id = "pagination">
			<ul class="pagination justify-content-center">
				<c:if test = "${pagination.prev }">
					<li class = "page-item">
						<a class = "page-link" href = "#" onclick = "fn_prev('${pagination.page}', '${pagination.range }', '${pagination.rangeSize }', '${pagination.searchType }', '${pagination.keyword }')">이전</a>
					</li>
				</c:if>
				<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
					<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
						<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType }', '${pagination.keyword }')"> ${idx} </a>
					</li>
				</c:forEach>
				<c:if test="${pagination.next }">
					<li class="page-item">
						<a class="page-link" href="#" onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType }', '${pagination.keyword }')" >다음</a>
					</li>
				</c:if>
			</ul>
		</div>
		<!-- Search  -->
		<div class = "form-group row justify-content-center">
			<div>
				<select class = "form-control form-control-sm" name = "searchType" id = "searchType">
					<option value = "title">제목</option>
					<option value = "content">본문</option>
					<option value = "insuser">사번</option>
				</select>
			</div>
			<div>
				<input type = "text" class = "form-control form-control-sm" name = "keyword" id = "keyword" value = "${pagination.keyword }">
			</div>
			<div>
				<button class = "btn btn-sm btn-primary float-right" name = "btnSearch" id = "btnSearch">검색</button>
			</div>
		</div>
	</div>
</body>
</html>