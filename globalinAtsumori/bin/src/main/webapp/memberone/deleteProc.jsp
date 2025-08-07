<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="domain.*" %>
<jsp:useBean id="dao" class="dao.MemberDAO" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<meta http-equiv="refresh" content="5;url=login.jsp">
</head>
<%
    String memberId = (String)session.getAttribute("loginID");
    String password = request.getParameter("password");

    int check = dao.deleteMember(memberId, password);

    if (check == 1) {
        session.invalidate();
%>
<body bgcolor="#fef7b5">
<div align="center">
<font size="5" face="맑은고딕">
입력하신 내용대로 <b>회원정보가 삭제 되었습니다.</b><br>
안녕히 가십시오.<br>
5초 후 Login Page로 이동합니다.
</font>
</div>
<% } else { %>
<script>
    alert("비밀번호가 맞지 않습니다.");
    history.go(-1);
</script>
<% } %>
<img src="images/goodbye.jpg" alt="잘가이미지" width="300" height="300">
</body>
</html>
