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

// 체크 박스
$(function () {
	var checkObj = document.getElementsByName("rowCheck");
	var rowCnt = checkObj.length;

	$("input[name = 'allCheck']").click(function() {
		var checkedList = $("input[name = 'rowCheck']");
		for (var i = 0; i < checkedList.length; i++) {
			checkedList[i].checked = this.checked;
		}
	});
	$("input[name = 'rowCheck']").click(function() {
		if($("input[name = 'rowCheck']:checked").length == rowCnt) {
			$("input[name = 'allCheck']")[0].checked = true;
		} else {
			$("input[name = 'allCheck']")[0].checked = false;
		}
	});
});

function setAdmin(empCode) {
	var empCode = empCode;
	// 프로미스 사용하여 컨트롤러로 값 넘기고 값 받아서 db로 세팅
	// jsp -> js -> controller -> service -> DB -> 결과return -> 사용자에게 표시
}
</script>
<body>
	<div class = "container">

		<br />
		<br />
		<h5>사용자 정보</h5>
		<div class = "float-right">
			<button type="button" class="btn btn-primary" id = "setAdmin" name = "setAdmin" onclick = "javascript:setAdmin(empCode);">설정</button>
			<button type="button" class="btn btn-primary" id = "deleteAdmin" name = "deleteAdmin">삭제</button>
		</div>
		<div class = "border" id = "bottomUserListAndFunction">
		<!-- Employee Table -->
		<div class = "table-responsive-md">
			<table class="table table-hover">
				<thead class = "table-light">
					<tr>
						<th scope = "col"><input id = "allCheck" type = "checkbox" name = "allCheck"></th>
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
							<td><input name = "rowCheck" type = "checkbox" value="${userList.empCode }"></td>
							<td><c:out value="${status.count }"></c:out></td>
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
		<div id = "bottomSearchAndPagination" class = "row">
			<!-- Search -->
			<div class = "col-9 row">
				<div class = "col-2">
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
				<div class = "col-8">
					<input type = "text" class = "form-control" name = "keyword" id = "keyword" value = "${pagination.keyword }" placeholder = "검색어를 입력해주세요">
				</div>
				<div class = "col-1">
					<button class = "btn btn-default btn-primary" type = "button" name = "btnSearch" id = "btnSearch">검색</button>
				</div>
			</div>
			<!-- Pagination -->
			<div id = "pagination" class = "col-3">
				<ul class="pagination pagination-sm">
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
		</div>
		</div>
		<br />
	</div>
</body>
</html>