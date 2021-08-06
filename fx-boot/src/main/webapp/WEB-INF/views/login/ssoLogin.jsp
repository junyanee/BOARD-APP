<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<iframe id="ssoUpdatePage" src="http://contract.samyang.com:9696/SetInfo.aspx?TicketID=${ticket}" style="visibility:hidden; display:none"></iframe>
	<script type="text/javascript">top.location.href='../' + ${url}</script>
</body>
</html>