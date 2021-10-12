<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
// 검색 버튼
$(document).on('click', '#btnSearch', function(e) {
	e.preventDefault();
	var url = "${pageContext.request.contextPath}/Info/searchUser.do";
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	location.href = url;
})
</script>
</head>
<body>
	<div class = "header-divider"></div>
	<div class = "container">
		<h1>사용자 검색</h1>
		<hr />
		<!-- Search  -->
		<div class = "form-group row">
			<div class = "col-1">
				<select name = "searchType" id = "searchType" class = "searchBar">
						<option value = "empName">이름</option>
						<option value = "empCode">사번</option>
				</select>
			</div>
			<div class = "col-10">
				<input type = "text" class = "form-control" name = "keyword" id = "keyword" value = "${keyword }" placeholder = "검색어를 입력해주세요">
			</div>
			<div class = "col"><button class = "btn btn-default btn-primary" type = "button" name = "btnSearch" id = "btnSearch">검색</button>
			</div>
		</div>
		<div id="profile" style="border: solid aliceblue; padding: 10px;">
			<p><span style="font-size: 1.5em;"> <strong> 유저 정보</strong></span> 총 ${fn:length(searchedUserList) }건의 검색결과</p>
			<div>
			<div style="display: flex">
				<div id="profileTable">
					<table class="table table-light">
						<tbody>
							<c:choose>
								<c:when test="${fn:length(searchedUserList) > 0 }">
									<c:forEach var = "searchedUserList" items = "${searchedUserList }" varStatus = "status">
									<c:choose>
										<c:when test="${searchedUserList.profileImagePath != null }">
											<td colspan = "2" rowspan = "6"><img src="downloadSearchedUserProfile.do?empCode=${searchedUserList.empCode }" width="200" height="200" alt="프로필사진" /></td>
										</c:when>
										<c:otherwise>
											<td colspan = "2" rowspan = "6">
											<img src ="/resources/img/common/blank-profile.png" width = "200" height = "200" alt = "프로필사진" />
											<p style = "text-align:center;">프로필 사진이 없습니다</p>
											</td>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${search.searchType eq 'empName' }">
											<tr> <th colspan = "2" style = "text-align:center;"> <strong>${searchedUserList.empName }</strong> 님의 정보입니다. [${status.count }] </th> </tr>
										</c:when>
										<c:when test="${search.searchType eq 'empCode' }">
											<tr> <th colspan = "2" style = "text-align:center;"> <strong>${searchedUserList.empCode }</strong> 님의 정보입니다. [${status.count }] </th> </tr>
										</c:when>
									</c:choose>
										<tr>
											<th style="text-align: center;">사번</th>
											<td>${searchedUserList.empCode }</td>
										</tr>
										<tr>
											<th style="text-align: center;">메일</th>
											<td>${searchedUserList.email }</td>
										</tr>
										<tr>
											<th style="text-align: center;">직무</th>
											<td>${searchedUserList.jobName }</td>
										</tr>
										<tr>
											<th style="text-align: center;">전화번호</th>
											<td>사무실 : ${searchedUserList.officeTelNum } / 핸드폰 :
												${searchedUserList.mobileTelNum }</td>
										</tr>
										<tr>
											<th colspan="3"></th>
										</tr>
									</c:forEach>
								</c:when>
								<c:when test="${searchedUserList != null && fn:length(searchedUserList) == 0 }">
									<p><span style="font-size:22px;">"${search.keyword }" </span>에 대한 검색 결과가 없습니다.</p>
								</c:when>
								<c:otherwise>
									<p>사용자를 검색해주세요.</p>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
	</div>
</body>
</html>