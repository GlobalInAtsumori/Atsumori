<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*, domain.*" %>
<jsp:useBean id="dao" class="dao.MemberDAO"/>
<jsp:useBean id="vo" class="domain.MemberVO">
    <jsp:setProperty name="vo" property="*" />
</jsp:useBean>

<%
    String memberId = (String)session.getAttribute("loginID");
    vo.setMemberId(memberId);
    dao.updateMember(vo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<meta http-equiv="refresh" content="5;url=login.jsp">
</head>
<body bgcolor="#fef7b5">
<div align="center">
<font size="5" face="맑은고딕">
입력하신 내용대로 회원 정보가 수정되었습니다.<br>
5초 후에 Login Page로 이동합니다.
</font>
</div>
</body>
</html>
