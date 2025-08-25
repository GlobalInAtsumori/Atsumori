<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>
<%@ include file="color.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="script.js"></script>
</head>

<%-- Controller에서 처리하므로 기존 스크립트릿 로직은 삭제합니다. --%>

<body bgcolor="<%=bodyback_c%>">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center"><br><b>글쓰기</b></div><br>
<form action="writeProc.do" method="post" name="writeForm">

<table width="470" border="1" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr>
		<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="list.do">글목록</a>
		</td>
</tr>

<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
	<td width="330">
			<input type="text" size="50" maxlength="50" name="title">
	</td>
</tr>

<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
	<td width="330">
		<textarea rows="13" cols="50" name="content"></textarea>
	</td>
</tr>

<tr>
		<td align="center" colspan="2" bgcolor="<%=value_c%>">
				<input type="submit" value="글쓰기">
				<input type="reset" value="다시작성">
				<input type="button" value="글목록"
				onclick="window.location='list.do'">
		</td>
</tr>


</table>

</form>
</div>
</body>
</html>
