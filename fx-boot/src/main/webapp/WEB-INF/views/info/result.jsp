<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class = "header-divider"></div>
<div class = "container"  id = "container">
			<div class="table-responsive-md">
			<table class="table table-hover">
				<thead class="table-light">
					<tr>
						<th scope="col">#</th>
						<th scope="col">이름</th>
						<th scope="col">나이</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="personList" items="${personList}" varStatus="status">
						<tr>
							<th scope="row"><c:out value="${status.count }" /></th>
							<td><c:out value="${personList.name }" /></td>
							<td><c:out value="${personList.age }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
</div>
</body>
</html>