<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%
 	String loginID = (String)session.getAttribute("loginID");
  %>
 
 
 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="style.css" rel ="stylesheet" type = "text/css">
</head>
<body bgcolor = "#fef7b5">

<% if(loginID != null ){ %>
<table width="300" border="1" >
	<tr>
		<td colspan ="3" align = "center">
		<%=loginID%>님 환영합니다.			
		</td>
	</tr>
	
	<tr>
		<td align = "center" width ="100">
			<a href="modifyForm.jsp">정보 수정</a></td>
			<td align = "center" width ="100">
			<a href="deleteForm.jsp">회원탈퇴</a></td>
			<td align = "center" width ="100">
			<a href="logout.jsp">로그아웃</a></td>
			
	</tr>
	
	
</table>

<%}else{ %> 



<form action="loginProc.jsp" method="post">
<table width="300" border="1" >
	<tr>
		<td colspan="2" align = "center">회원 로그인</td>
	</tr>

		<tr>
			<td align="center" width= "100">id</td>
			<td width="200"> &nbsp;&nbsp;
			<input type="text" name="id" size="20">
			</td>
		</tr>

		<tr>
			<td align="center" width= "100">🔐비밀번호🔐</td>
			<td width="200"> &nbsp;&nbsp;
			<input type="password" name="pass" size="20">
			</td>
		</tr>

	<tr>
		<td colspan="2" align = "center">
		<input type="submit" value = "로그인"> &nbsp;&nbsp;
		<input type="button" value = "회원가입"
		onclick="javascript:window.location='regForm.jsp'">
		</td>
	</tr>

</table>
</form>
<%} %>
<img src="images/welcome.jpg" alt="로고 이미지" width="300" height="300">

</body>
</html>