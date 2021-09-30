<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script>
function getMore() {
	var url = "getMyBoardListAll.do";
	location.href = url;
}
</script>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
	<div class = "container">
	<br>
	<div style = "display:flex">
		<h3><c:out value="[${sessionScope.userInfo.sygCode }] ${sessionScope.userInfo.empName }"></c:out></h3> <span style="padding-top: 10px;">님의 페이지</span>
	</div>
	<hr />

	<div id = "profile" style= "border: solid aliceblue; padding: 10px;">
	<span style = "font-size:1.5em;"> <strong>사용자 정보</strong> </span>
		<div style = "display:flex">
			<div id = "profilePicture" style = "padding-right: 10px;">
				<img src ="/resources/img/common/blank-profile.png" width = "200" height = "200" alt = "프로필사진" />
			</div>
			<div id = "profileTable">
				<table class = "table table-bordered">
					<tbody>
						<tr>
							<th style = "text-align:center;">사번</th>
							<td>${sessionScope.userInfo.empCode }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">메일</th>
							<td>${sessionScope.userInfo.email }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">직무</th>
							<td>${sessionScope.userInfo.jobName }</td>
						</tr>
						<tr>
							<th style = "text-align:center;">전화번호</th>
							<td>사무실 : ${sessionScope.userInfo.officeTelNum} / 핸드폰 : ${sessionScope.userInfo.mobileTelNum }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<hr />
	<div>
		<div style = "float:left;">
			<span style = "font-size:1.5em;"> <strong>내가 쓴 글</strong> </span>
		</div>
		<div style = "float:right; padding-bottom:10px;">
			<span>상위 5개만 표시됩니다.</span>
			<button class = "btn btn-primary" onclick = "javascript:getMore();">더보기</button>
		</div>
	</div>
		<div class="table-responsive-md">
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope = "col"><input id = "allCheck" type = "checkbox" name = "allCheck"></th>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">날짜</th>
						<th scope="col">조회수</th>
						<th scope="col">댓글수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="myBoardList" items="${myBoardList}" varStatus="status">
						<c:choose>
							<c:when test="${myBoardList.isNotice == 1}">
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<td><c:out value="<strong>[공지]</strong>" escapeXml = "false"></c:out></td>
									<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="<strong>${myBoardList.title }</strong>" escapeXml = "false"/> </a> </td>
									<td><c:out value="<strong>${myBoardList.insertUser }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.insertDate }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.readCnt }</strong>" escapeXml = "false"/></td>
									<td><c:out value="<strong>${myBoardList.commentCnt }</strong>" escapeXml = "false"/></td>
								</tr>
							</c:when>
							<c:when test = "${myBoardList.isSecret == 1}">
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<c:choose>
										<c:when test = "${sessionScope.userInfo.empCode == myBoardList.insertUser}">
											<td><c:out value="${myBoardList.idx }" /></td>
											<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="${myBoardList.title } (비공개 처리됨)" /> </a> </td>
											<td><c:out value="${myBoardList.insertUser }"/></td>
											<td><c:out value="${myBoardList.insertDate }"/></td>
											<td><c:out value="${myBoardList.readCnt }"/></td>
											<td><c:out value="${myBoardList.commentCnt }"/></td>
										</c:when>
										<c:otherwise>
											<td><c:out value="${myBoardList.idx }"></c:out></td>
											<td><c:out value="비공개 게시글입니다." /></td>
											<td><c:out value="익명사용자"/></td>
											<td><c:out value="${myBoardList.insertDate }"/></td>
											<td><c:out value="${myBoardList.readCnt }"/></td>
											<td><c:out value="${myBoardList.commentCnt }"/></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td scope = "col"><input id = "rowCheck" type = "checkbox" name = "rowCheck" value = "${myBoardList.idx }"></td>
									<td><c:out value="${myBoardList.idx }" /></td>
									<td> <a href="/boardDetail.do?idx=${myBoardList.idx}"><c:out value="${myBoardList.title }" /> </a> </td>
									<td><c:out value="${myBoardList.insertUser }" /></td>
									<td><c:out value="${myBoardList.insertDate }" /></td>
									<td><c:out value="${myBoardList.readCnt }" /></td>
									<td><c:out value="${myBoardList.commentCnt }" /></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>