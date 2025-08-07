<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setAttribute("bannerMessage", "✏️中古品売買✏️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✏️中古品売買✏️</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/secondhand.css">
<script type="text/javascript" src="secondhandScript.js"></script>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
	
		<form action="shWriteProc.jsp" method="post" name="shWriteForm" onsubmit="return shWriteSave()">
			<table class="shWrite">
				<tr>
					<td class="textonly">subject</td>
					<td>input</td>
				</tr>
				<tr>
					<td class="textonly">price</td>
					<td>input</td>
				</tr>
				<tr>
					<td class="textonly">content</td>
					<td>input</td>
				</tr>
				<tr>
					<td>submit</td>
					<td>input</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>