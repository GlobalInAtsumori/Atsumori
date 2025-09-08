<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<% request.setAttribute("bannerMessage", "雑談掲示板"); %>

<%--
<%@ include file="color.jsp" %>
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

<div align="center"><br><b>編集</b></div><br>
<form action="updateProc" method="post" name="updateForm">
	<input type="hidden" name="boardno" value="${article.boardno}">
    <input type="hidden" name="pageNum" value="${pageNum}">

	<table width="500" border="2" cellpadding="0" cellspacing="0"
		align="center" bgcolor="${bodyback_c}">
		<tr>
			<td align="right" colspan="2" bgcolor="${value_c}">
				<a href="list?pageNum=${pageNum}">投稿一覧</a>
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="${value_c}" align="center">タイトル</td>
			<td width="330">
				<input type="text" size="50" maxlength="50" name="title" value="${article.title}">
			</td>
		</tr>
		<tr>
			<td width="70" bgcolor="${value_c}" align="center">内容</td>
			<td width="330">
				<textarea rows="13" cols="50" name="content">${article.content}</textarea>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2" bgcolor="${value_c}">
				<input type="submit" value="編集">
				<input type="button" value="投稿一覧" onclick="window.location='list?pageNum=${pageNum}'">
			</td>
		</tr>
	</table>
</form>

</div>
</body>
</html>