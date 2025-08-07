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
			<table>
			<!-- 테스트용 간단 폼 -->
				<tr>
					<td>상품명</td>
					<td>
						<input type="text" size="50" maxlength="50" name="tradeTitle">
					</td>
				</tr>
				
				<tr>
					<td>
						<input type="submit" value="shWrite">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>