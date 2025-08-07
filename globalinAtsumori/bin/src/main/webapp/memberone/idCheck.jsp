<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="domain.*" %>
<jsp:useBean id="dao" class="dao.MembercheckDAO"/>

<%
    String id = request.getParameter("id");
	boolean check = dao.idCheck(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 체크</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="#fef7b5">
<br>
<div align="center"></div>
<b><%=id %></b>
<%
if(check){
    out.println("는 이미 존재하는 ID입니다.<br>");
}else{
    out.println("는 사용 가능한 ID입니다.<br>");
}
%>
<a href="#" onclick="javascript: self.close()">닫기</a>
</body>
</html>
