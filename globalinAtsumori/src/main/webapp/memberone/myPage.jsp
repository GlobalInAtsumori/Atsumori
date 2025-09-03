<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%


String loginID = (String) session.getAttribute("loginID");
if(loginID == null){
    out.println("<script>alert('먼저 로그인 해주세요'); location.href='login.jsp';</script>");
    return;
}


request.setAttribute("bannerMessage", "마이페이지");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/includes/navbar.jsp" />
<jsp:include page="/includes/banner.jsp" />
<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

		
		<!-- 여기까지가 상단부   이 밑으로는 페이지 내용 등등 -->
		
		<br><br><br>
		<table class="reg-table">
		
		
		<tr> <td>
		<a href="<%= request.getContextPath() %>/memberone/deleteForm.jsp">회원탈퇴(테스트용)</a><br><br>
		 <a href="<%= request.getContextPath() %>/memberone/modifyForm.jsp">회원정보 수정(테스트용)</a>
		</td> </tr>
		
		
</table>

	</div>
</body>
</html>
