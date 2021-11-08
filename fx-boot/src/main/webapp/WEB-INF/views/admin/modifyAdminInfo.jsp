<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "_csrf" content="${_csrf.token }"/>
<meta name = "_csrf_header" content="${_csrf.headerName }" />
<title>관리자 권한 설정</title>
</head>
<script type="text/javascript">
$(document).ready(function (){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function (e, xhr, options){
		xhr.setRequestHeader(header, token);
	})
});

// 이전 버튼
function fn_prev(page, range, rangeSize, searchType, keyword) {
	var page = ((range - 2) * rangeSize) + 1;
	var range = range - 1;

	var url = "${pageContext.request.contextPath}/admin/modifyAdminInfo.do"
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchTypeTop').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}

// 페이지 번호 클릭
function fn_pagination(page, range, rangeSize, searchType, keyword) {
	var url = "${pageContext.request.contextPath}/admin/modifyAdminInfo.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchTypeTop').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}

// 다음 버튼
function fn_next(page, range, rangeSize, searchType, keyword) {
	var page = parseInt((range * rangeSize)) + 1;
	var range = parseInt(range) + 1;

	var url = "${pageContext.request.contextPath}/admin/modifyAdminInfo.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + $('#searchTypeTop').val();
		url = url + "&keyword=" + keyword;
		location.href = url;
}
// 검색 버튼
$(document).on('click', '#btnSearchTop', function(e) {
	e.preventDefault();
	var url = "${pageContext.request.contextPath}/admin/modifyAdminInfo.do";
	url = url + "?searchType=" + $('#searchTypeTop').val();
	url = url + "&keyword=" + $('#keywordTop').val();
	location.href = url;
})

// 체크 박스
$(function () {
	var checkObj = document.getElementsByName("rowCheckTop");
	var rowCnt = checkObj.length;

	$("input[name = 'allCheckTop']").click(function() {
		var checkedList = $("input[name = 'rowCheckTop']");
		for (var i = 0; i < checkedList.length; i++) {
			checkedList[i].checked = this.checked;
		}
	});
	$("input[name = 'rowCheckTop']").click(function() {
		if($("input[name = 'rowCheckTop']:checked").length == rowCnt) {
			$("input[name = 'allCheckTop']")[0].checked = true;
		} else {
			$("input[name = 'allCheckTop']")[0].checked = false;
		}
	});
});

// 관리자 권한 변경

function modifyAuthLevel() {
	var isChecked = $("input[name = 'rowCheckTop']:checked");
	if (isChecked.length == 0) {
		alert("권한을 변경할 관리자를 체크하세요.");
	} else {
		var result = confirm("권한을 변경하시겠습니까?");
		if(result) {
			var checkedList = $("input[name = 'rowCheckTop']");
			var selectedList = $("select[name = 'authLevel']");
			for (var i = 0; i < checkedList.length; i++) {
				if (checkedList[i].checked) {
					var param1 = checkedList[i].value;
					var param2 = selectedList[i].value;

					var ajaxOptions = {
							SvcName: "/admin",
							MethodName: "modifyAuthLevel.do",
							Params : { param1 : param1, param2 : param2 },
							Callback : function(result) {
								if(result.isSuccess = 'true') {
									alert(result.resultMsg);
									location.reload(true);
								} else {
									alert(result.resultMsg);
								}
							}
						};

					var promise = new Promise(function(resolve, reject) {
						$.fng_Ajax(ajaxOptions);
						if(resolve) {
							resolve("권한 변경이 완료되었습니다.");
						} else {
							reject(Error("권한이 변경되지 않았습니다."));
						}
					});
				}

			}
			Promise.all([promise]).then(function (values) {
				location.reload(true);
			});
		}
	}
}
</script>
<body>
	<div class = "header-divider"></div>
	<div class = "container" id = "container">
		<h5>관리자 권한 설정</h5>
		<div class = "float-left">
		<p>관리자 권한을 설정하세요</p>
		</div>
		<div class = "float-right">
			<button type="button" class="btn btn-primary" id = "modifyAuthLevel" name = "modifyAuthLevel" onclick = "javascript:modifyAuthLevel()">권한 변경</button>
			<a href = "addAdmin.do"><button type="button" class="btn btn-primary" id = "addAdmin" name = "addAdmin">관리자 추가/삭제</button></a>
		</div>
		<div class = "border" id = "topUserListAndFunction">
		<!-- Employee Table -->
		<div class = "table-responsive-md">
			<table class="table table-hover">
				<thead class = "table-light">
					<tr>
						<th scope = "col"><input id = "allCheckTop" type = "checkbox" name = "allCheckTop"></th>
						<th scope = "col">#</th>
						<th scope = "col">사번</th>
						<th scope = "col">이름</th>
						<th scope = "col">권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var = "adminList" items = "${adminList }" varStatus = "status">
						<tr>
							<td><input id = "rowCheckTop" name = "rowCheckTop" type = "checkbox" value="${adminList.adminCode }"></td>
							<td><c:out value="${status.count }"></c:out></td>
							<td><c:out value="${adminList.empCode }" /></td>
							<td><c:out value="${adminList.adminName }" /></td>
							<td>
								<select id = "authLevel" name = "authLevel">
									<option value = "0" disabled <c:if test = "${adminList.authLevel == 0 }"> selected </c:if>>루트관리자</option>
									<option value = "1" <c:if test = "${adminList.authLevel == 1 }"> selected </c:if>>관리자</option>
									<option value = "2" <c:if test = "${adminList.authLevel == 2 }"> selected </c:if>>매니저</option>
								</select>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id = "topSearchAndPagination" class = "row">
			<!-- Search -->
			<div class = "col-9 row">
				<div class = "col-2">
					<select name = "searchTypeTop" id = "searchTypeTop" class = "searchBar">
						<option value = "adminName">이름</option>
						<option value = "empCode">사번</option>
					</select>
				</div>
				<div class = "col-8">
					<input type = "text" class = "form-control" name = "keywordTop" id = "keywordTop" value = "${pagination.keyword }" placeholder = "검색어를 입력해주세요">
				</div>
				<div class = "col-1">
					<button class = "btn btn-default btn-primary" type = "button" name = "btnSearch" id = "btnSearchTop">검색</button>
				</div>
			</div>
			<!-- Pagination -->
			<div id = "paginationTop" class = "col-3">
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