<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- css -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/error/500.css" />"/>
<script>
$(document).ready(function (){
	$(".full-screen").mousemove(function(event) {
		  var eye = $(".eye");
		  var x = (eye.offset().left) + (eye.width() / 2);
		  var y = (eye.offset().top) + (eye.height() / 2);
		  var rad = Math.atan2(event.pageX - x, event.pageY - y);
		  var rot = (rad * (180 / Math.PI) * -1) + 180;
		  eye.css({
		    '-webkit-transform': 'rotate(' + rot + 'deg)',
		    '-moz-transform': 'rotate(' + rot + 'deg)',
		    '-ms-transform': 'rotate(' + rot + 'deg)',
		    'transform': 'rotate(' + rot + 'deg)'
		  });
		});
});


</script>
<meta charset="UTF-8">
<title>500</title>
</head>
<body>
<div class="full-screen">
	<div class='container'>
		<span class="error-num">5</span>
		<div class="eye"></div>
        <div class="eye"></div>
        <p class="sub-text">에러발생</p>
        <a href="/Common/home.do">홈으로</a>
	</div>
</div>
</body>
</html>