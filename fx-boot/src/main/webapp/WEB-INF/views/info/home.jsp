<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function insert() {
	var result = confirm("제출하시겠습니까?");
	var formData = $(insertTestForm).serializeObject();
	if(result) {
		$.ajax({
			type : "POST",
			url : "/Common/insertTest.do",
			data : JSON.stringify(formData),
			contentType: 'application/json',
			dataType : 'text',
			success : function(response){
				alert("성공");
				var url = "/Common/insertResult.do"
				location.href = url;
			},
			error : function(response) {
				alert("실패");
				console.log(JSON.stringify(response))
			}
		})
	}
}
</script>
<meta charset="UTF-8">
<title>메인 게시판</title>
</head>
<body>
	<div class = "container" id = "container">
		<h1>info home</h1>
	<form id = "insertTestForm" name = "insertTestForm">
		<div>
		<div>
			<label>이름</label>
			<input type="text" id="name" name="name">
		</div>
		<div>
			<label>나이</label>
			<input type="text" id="age" name="age">
		</div>
		</div>
	</form>
		<button type = "button" id = "submitButton" onclick = "javascript:insert();">제출</button>
		<a href = "/Common/insertResult.do"><button type = "button">결과</button></a>
	</div>
</body>
</html>