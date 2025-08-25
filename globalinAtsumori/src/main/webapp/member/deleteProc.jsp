<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="member.*" %>
    <jsp:useBean id="dao" class="member.StudentDAO" />
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<meta http-equiv="refresh" content="5;url=login.jsp"> <%--5초후에 로그인 페이지로 이동하는 거 --%>
</head>
<%
	String id =(String)session.getAttribute("loginID");
	String pass = request.getParameter("pass");

	int check = dao.deleteMember(id, pass);
	
	if(check == 1){
		session.invalidate();
%>
<body>
<div align="center">
<font size="5" face="궁서체">
<b>회원정보가 삭제 되었습니다.</b><br>
안녕히 가십시요. (ㅜ__ㅠ) <br>
5초 후에 Login page로 이동합니다.
</font>
</div>
<%}else{ %>
<script type="text/javascript">
alert("실패했네요");

</script>



<%} %>

</body>
</html>