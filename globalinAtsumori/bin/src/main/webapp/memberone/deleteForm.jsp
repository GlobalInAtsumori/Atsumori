<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "domain.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script type="text/javascript" src="script.js"></script>
</head>
<body onload ="begin()" bgcolor = "#fef7b5">
<form action="deleteProc.jsp" name= "myform" onsubmit="return check">
<table width="260" border="1" align="center">
	<tr>
		<td colspan="2" align="center">
			<b>😭회원탈퇴😭</b> 
		</td>
	</tr>
	
	<tr>
		<td width="150"><b>비밀번호</b></td>
		<td width="110">
			<input type="password" name="pass" size="15">
		</td>
	</tr>
	
	
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="회원탈퇴">
			<input type="button" value="취소" onclick ="javascript:window.location='login.jsp'">
	
	<tr>
		<td colspan="2" align="center">
			<b>회원탈퇴</b> 
		</td>
	</tr>
			
</table>





</form>
<img src="images/goodbye.jpg" alt="잘가이미지" width="300" height="300">
</body>
</html>