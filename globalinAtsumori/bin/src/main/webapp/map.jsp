<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setAttribute("bannerMessage", "グルメツアー");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아쯔모리</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		
		
	</div>
</body>
</html>