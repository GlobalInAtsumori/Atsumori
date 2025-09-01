<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setAttribute("bannerMessage", "회원탈퇴");
%>
    <%
    session.invalidate();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<meta http-equiv="refresh" content ="5;url=login.jsp">
<link rel="stylesheet" href="../css/style.css">
</head>
<body align="center">
	<div class="wrapper">

		<jsp:include page="../includes/navbar.jsp" />
		<jsp:include page="../includes/banner.jsp" />



<font size ="5" face="맑은고딕">
<br>
<br>
<br>
성공적으로 로그아웃 되었습니다.

</font>
</div>
</body>
</html> 