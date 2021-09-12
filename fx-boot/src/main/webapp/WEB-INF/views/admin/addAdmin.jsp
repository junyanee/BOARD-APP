<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 권한 설정</title>
</head>
<script type="text/javascript">
// 이전 버튼
function fn_prev(page, range, rangeSize, searchType, keyword) {
	var page = ((range - 2) * rangeSize) + 1;
	var range = range - 1;

	var url = "${pageContext.request.contextPath}/admin/addAdmin.do"
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}

// 페이지 번호 클릭
function fn_pagination(page, range, rangeSize, searchType, keyword) {
	var url = "${pageContext.request.contextPath}/admin/addAdmin.do";
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

	var url = "${pageContext.request.contextPath}/admin/addAdmin.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchType').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}
// 검색 버튼
$(document).on('click', '#btnSearch', function(e) {
	e.preventDefault();
	var url = "${pageContext.request.contextPath}/admin/addAdmin.do";
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	location.href = encodeURI(url);
	console.log(url);
})
</script>
<body>
	<div class = "container">
		<!-- Search  -->
		<div class = "form-group row">
			<div class = "col-1">
				<select name = "searchType" id = "searchType"
				style = "
				color: #495057;
                background-color: #fff;
                border-color: #ced4da;
                display: inline-block;
                padding: 6px 12px;
                margin-bottom: 0;
                font-size: 14px;
                font-weight: 400;
                line-height: 1.42857143;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                -ms-touch-action: manipulation;
                touch-action: manipulation;
                cursor: pointer;
                background-image: none;
                border: 1px solid;
                border-radius: 4px;
                ">
						<option value = "empName">이름</option>
						<option value = "empCode">사번</option>
				</select>
			</div>
			<div class = "col-10">
				<input type = "text" class = "form-control" name = "keyword" id = "keyword" value = "${pagination.keyword }" placeholder = "검색어를 입력해주세요">
			</div>
			<div class = "col">
				<button class = "btn btn-default btn-primary" type = "button" name = "btnSearch" id = "btnSearch">검색</button>
			</div>
		</div>
		<div class = "table-responsive-md">
			<table class="table table-hover">
				<thead class = "table-light">
					<tr>
						<th scope = "col">#</th>
						<th scope = "col">사번</th>
						<th scope = "col">이름</th>
						<th scope = "col">역할</th>
						<th scope = "col">관리자 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var = "userList" items = "${userList }" varStatus = "status">
						<tr>
							<th scope = "row"><c:out value="${status.count }" /></th>
							<td><c:out value="${userList.empCode }" /></td>
							<td><c:out value="${userList.empName }" /></td>
							<td><c:out value="${userList.jobName }" /></td>
							<td><c:choose>
									<c:when test = "${userList.isAdmin == 1}"><c:out value= "관리자"/></c:when>
									<c:otherwise><c:out value="일반" /></c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
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
		<br />
	</div>
</body>
</html>