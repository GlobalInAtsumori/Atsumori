<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>
<%@ include file="color.jsp" %>
<%
int boardno = (Integer) request.getAttribute("boardno");
String pageNum = (String) request.getAttribute("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="<%=bodyback_c%>">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center">
<br><b>글삭제</b><br><br>
<form action="deleteProc.do?pageNum=<%=pageNum %>" 
name="delForm" method="post" onsubmit="return deleteSave()">
<table width="360" border="1" align="center" cellpadding="0" cellspacing="0">

<tr height="30">
	<td align="center" bgcolor="<%=value_c%>">
	   <b>비밀번호를 입력해 주세요.</b>
	</td>
</tr>
	
<tr height="30">
	<td align="center">
	   비밀번호 :<input type="password" name="pass" size="10 maxlength="10">
	   <input type="hidden" name="boardno" value="<%=boardno%>">
	</td>
</tr>

<tr height="30">
    <td align="center" bgcolor="<%=value_c%>">
        <input type="submit" value="글삭제">
        <input type="button" value="📑글목록"
        onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
    </td>
</tr>
</table>
</form>

</div>

</div>
</body>
</html>