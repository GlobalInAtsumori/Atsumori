<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%
    String loginID = (String) session.getAttribute("loginID");
    if (loginID == null) {
        // 로그인 안 되어 있으면 login.jsp로 이동
        response.sendRedirect("memberone/login.jsp");
        return;
    }
%> 
<%
	request.setAttribute("bannerMessage", "アツモリにようこそ！");
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
    <div class="main-image">
			<img src="https://i.pinimg.com/736x/be/ff/20/beff2017ae20d0162213c40dc3931208.jpg" alt="메인 이미지">
		</div>

	</div>
</body>
</html>
