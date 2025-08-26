<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.memberone.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="dao" class="com.memberone.StudentDAO" />

<jsp:useBean id="vo" class="com.memberone.StudentVO">
	<jsp:setProperty name="vo" property="*" />
</jsp:useBean>

<%
	String loginID = (String)session.getAttribute("loginID");
	vo.setId(loginID);
	dao.updateMember(vo);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<meta http-equiv="refresh" content="5;url=login.jsp"> <%--5초후에 로그인 페이지로 이동하는 거 --%>
</head>

<body>
<div align="center">
<font size="5" face="궁서체">
입력하신 내용대로 <b>회원정보가 수정 되었습니다.</b><br>
5초 후에 Login page로 이동합니다.
</font>
</div>

</body>
</html>