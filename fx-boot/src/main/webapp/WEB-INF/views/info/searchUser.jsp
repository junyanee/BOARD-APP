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
</head>
<body>
	<div class = "header-divider"></div>
	<div class = "container">
		<h1>사용자 검색</h1>
		<hr />
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
		<div id="profile" style="border: solid aliceblue; padding: 10px;">
			<span style="font-size: 1.5em;"> <strong>사용자 정보</strong>
			</span>
			<div style="display: flex">
				<div id="profilePicture"
					style="padding-right: 10px; border: dotted thick aliceblue;">
					<c:choose>
						<c:when test="${sessionScope.userInfo.profileImagePath != null }">
							<img src="downloadProfile.do" width="200" height="200"
								alt="프로필사진" />
						</c:when>
						<c:otherwise>
							<img src="/resources/img/common/blank-profile.png" width="200"
								height="200" alt="프로필사진" />
							<p style="text-align: center;">프로필 사진이 없습니다</p>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="profileTable">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th style="text-align: center;">사번</th>
								<td>1</td>
							</tr>
							<tr>
								<th style="text-align: center;">메일</th>
								<td>abd@email.com</td>
							</tr>
							<tr>
								<th style="text-align: center;">직무</th>
								<td>사장사장</td>
							</tr>
							<tr>
								<th style="text-align: center;">전화번호</th>
								<td>사무실 : 02-300-0000 / 핸드폰 :
									010-0000-0000</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>