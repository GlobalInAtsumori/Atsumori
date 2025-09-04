<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 세션에 loginID가 있으면 바로 mainPage.jsp로 리다이렉트
String loginID = (String) session.getAttribute("loginID");
if (loginID != null) {
	response.sendRedirect("/mainPage.jsp");



	return; // 리다이렉트 후 JSP 코드 더 이상 실행되지 않도록 종료
}

// 배너 메시지 설정
request.setAttribute("bannerMessage", "로그인");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body align="center">
	<div class="wrapper">

		<jsp:include page="../includes/navbar.jsp" />
		<jsp:include page="../includes/banner.jsp" />
		<br> <br> <br>

		<!-- 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/memberone/loginProc.jsp"
			method="post">

			<table class="login-table">
				<tr>
					<h2 align="center">ログイン</h2>
				</tr>
				<tr>
					<td class="label">ID</td>
					<td width="200">&nbsp; <input type="text" name="memberId"
						class="reg-input"></td>
				</tr>
				<tr>
					<td class="label">PW</td>
					<td width="200">&nbsp; <input type="password" name="password"
						class="reg-input"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						class="reg-btn" value="ログイン"></td>
				</tr>
			</table>
		</form>

	</div>
</body>
</html>
