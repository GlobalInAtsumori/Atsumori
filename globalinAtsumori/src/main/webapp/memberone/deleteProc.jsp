<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<jsp:useBean id="dao" class="dao.MemberDAO" />

<%
    String memberId = (String)session.getAttribute("loginID");
    String password = request.getParameter("password");

    boolean result = dao.deleteMember(memberId, password);

    if(result) {
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
<meta http-equiv="refresh" content="5;url=login.jsp">
<% 
    } else { 
%>
<script>
    alert("비밀번호가 맞지 않거나 회원 탈퇴에 실패했습니다.");
    history.go(-1);
</script>
<% } %>
</body>
</html>
