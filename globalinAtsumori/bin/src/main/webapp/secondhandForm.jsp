<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setAttribute("bannerMessage", "✏️中古品売買✏️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✏️中古品売買✏️</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/basic.css">
</head>
<body>

	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
	
		<form action="shWriteProc.jsp" method="post" name="shWriteForm" >
			<table>
			 <!-- https://www.notion.so/JSP-25-08-01-24210a18eeda80a78980ee54a4b9839e-->
			</table>
		</form>
	</div>
</body>
</html>