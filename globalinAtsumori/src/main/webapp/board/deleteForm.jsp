<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setAttribute("bannerMessage", "雑談掲示板"); %>


<%-- JSTL을 사용하므로 스크립틀릿 코드를 주석 처리하거나 제거함
<%@ include file="color.jsp" %>
<%
int boardno = (Integer) request.getAttribute("boardno");
String pageNum = (String) request.getAttribute("pageNum");
%>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>雑談掲示板</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="${bodyback_c}">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center">
<br><b>削除</b><br><br>
<form action="deleteProc?pageNum=${pageNum}" name="delForm" method="post">
<table width="360" border="2" align="center" cellpadding="0" cellspacing="0">

<tr height="30">
	<td align="center" bgcolor="${value_c}">
	   <b>この内容を削除しますか？</b>
	</td>
</tr>
	
<tr height="30">
	<td align="center">
	   <input type="hidden" name="boardno" value="${boardno}">
	</td>
</tr>

<tr height="30">
    <td align="center" bgcolor="${value_c}">
        <input type="submit" value="削除">
        <input type="button" value="投稿一覧" onclick="document.location.href='list?pageNum=${pageNum}'">
    </td>
</tr>
</table>
</form>

</div>

</div>
</body>
</html>