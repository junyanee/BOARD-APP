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
	location.href = url;
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

// 선택 삭제
function deleteChecked() {
	var isChecked = $("input[name = 'rowCheck']:checked");
	if(isChecked.length == 0) {
		alert("게시물을 선택하세요.");
	} else {
		var result = confirm("선택된 게시물을 삭제하시겠습니까?");
		if(result) {
			var checkedList = $("input[name = 'rowCheck']");
			for (var i = 0; i < checkedList.length; i++) {
				if (checkedList[i].checked) {
					var param = checkedList[i].value;

					var ajaxOptions = {
							SvcName : "",
							MethodName : "deleteChecked.do",
							Params : { param : param }
					};

					var promise = new Promise(function (resolve, reject) {
						$.fng_Ajax(ajaxOptions);
						if(resolve) {
							resolve("정상적으로 삭제되었습니다.");
						} else {
							reject(Error("정상적으로 삭제되지 못했습니다."))
						}
					});
				}
			}
			Promise.all([promise]).then(function (values) {
				alert(values);
				location.reload(true);
			});
		}
	}
}

</script>
<meta charset="UTF-8">
<title>메인 게시판</title>
</head>
<body>
	<div class = "header-divider"></div>
	<div class="container" id = "container">
		<h2>메인 게시판</h2>
		<hr>
		<!-- Search  -->
		<div class = "form-group row">
			<div class = "col-1">
				<select name = "searchType" id = "searchType" class = "searchBar">
						<option value = "title">제목</option>
						<option value = "content">본문</option>
						<option value = "insuser">사번</option>
				</select>
			</div>
			<div class = "col-10">
				<input type = "text" class = "form-control" name = "keyword" id = "keyword" value = "${pagination.keyword }" placeholder = "검색어를 입력해주세요">
			</div>
			<div class = "col">
				<button class = "btn btn-default btn-primary" type = "button" name = "btnSearch" id = "btnSearch">검색</button>
			</div>
		</div>
		<div class="table-responsive-md">
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<c:if test="${sessionScope.adminInfo != null }">
						<th scope = "col"><input id = "allCheck" type = "checkbox" name = "allCheck"></th>
						</c:if>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
						<th scope="col">댓글수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="boardList" items="${boardList}" varStatus="status">
						<c:choose>
							<c:when test="${boardList.isNotice == 1}">
								<tr>
									<c:if test="${sessionScope.adminInfo != null }">
										<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${boardList.idx }"></td>
									</c:if>
										<td><c:out value="<strong>[공지]</strong>" escapeXml = "false"></c:out></td>
										<td> <a href="/boardDetail.do?idx=${boardList.idx}"><c:out value="<strong>${boardList.title }</strong>" escapeXml = "false"/> </a> </td>
										<td><c:out value="<strong>${boardList.insertUser }</strong>" escapeXml = "false"/></td>
										<td><c:out value="<strong>${boardList.insertDate }</strong>" escapeXml = "false"/></td>
										<td><c:out value="<strong>${boardList.readCnt }</strong>" escapeXml = "false"/></td>
										<td><c:out value="<strong>${boardList.commentCnt }</strong>" escapeXml = "false"/></td>
								</tr>
							</c:when>
							<c:when test = "${boardList.isSecret == 1}">
								<tr>
									<c:if test="${sessionScope.adminInfo != null }">
										<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${boardList.idx }"></td>
									</c:if>
									<c:choose>
										<c:when test = "${sessionScope.userInfo.empCode == boardList.insertUser || sessionScope.userInfo.isAdmin < 3}">
											<td><c:out value="${boardList.idx }" /></td>
											<td> <a href="/boardDetail.do?idx=${boardList.idx}"><c:out value="${boardList.title } (비공개 처리됨)" /> </a> </td>
											<td><c:out value="${boardList.insertUser }"/></td>
											<td><c:out value="${boardList.insertDate }"/></td>
											<td><c:out value="${boardList.readCnt }"/></td>
											<td><c:out value="${boardList.commentCnt }"/></td>
										</c:when>
										<c:otherwise>
											<td><c:out value="${boardList.idx }"></c:out></td>
											<td><c:out value="비공개 게시글입니다." /></td>
											<td><c:out value="익명사용자"/></td>
											<td><c:out value="${boardList.insertDate }"/></td>
											<td><c:out value="${boardList.readCnt }"/></td>
											<td><c:out value="${boardList.commentCnt }"/></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<c:if test="${sessionScope.adminInfo != null }">
										<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${boardList.idx }"></td>
									</c:if>
										<td><c:out value="${boardList.idx }" /></td>
										<td> <a href="/boardDetail.do?idx=${boardList.idx}"><c:out value="${boardList.title }" /> </a> </td>
										<td><c:out value="${boardList.insertUser }" /></td>
										<td><c:out value="${boardList.insertDate }" /></td>
										<td><c:out value="${boardList.readCnt }" /></td>
										<td><c:out value="${boardList.commentCnt }" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class = "float-right">
			<!-- 로그인 정보 있을때만 글쓰기 버튼 출력 -->
			<c:choose>
				<c:when test = "${sessionScope.userInfo != null }">
					<a href="/boardWrite.do"><button type = "button" class="btn btn-primary">글쓰기</button></a>
					<c:choose>
						<c:when test="${sessionScope.adminInfo != null }">
							<button type = "button" class = "btn btn-primary" onclick = "javascript:deleteChecked();">선택 삭제</button>
						</c:when>
					</c:choose>
				</c:when>
			</c:choose>
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
		<br />

	</div>
</body>
</html>