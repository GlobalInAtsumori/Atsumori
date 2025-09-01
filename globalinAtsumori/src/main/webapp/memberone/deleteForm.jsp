<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setAttribute("bannerMessage", "회원탈퇴");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아쯔모리</title>
	<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="../includes/navbar.jsp" />
		<jsp:include page="../includes/banner.jsp" />
<br><br>
                 <form action="deleteProc.jsp" name="myform" onsubmit="return check">
		<table class="reg-table">
			<tr>
				<td colspan="2" align="center"><b>회원탈퇴</b></td>
			</tr>

			<tr>
				<td width="150" align = "center"><b>비밀번호</b></td>

				<td width="110"><input type="password" name="pass" size="15">
				</td>
			</tr>



			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="회원탈퇴"></td>
			</tr>
			


		</table>





	</form>
	</div>
</body>
</html>
