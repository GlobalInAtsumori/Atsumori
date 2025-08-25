<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>

<%@ include file="color.jsp" %>
<%@ page import="dto.BoardDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="script.js"></script>
</head>

<%-- Controller가 Model에 담아준 데이터를 사용합니다 --%>
<%
    // Controller에서 "article"이라는 이름으로 넘겨준 BoardDTO 객체를 가져옵니다.
    BoardDTO article = (BoardDTO) request.getAttribute("article");
    // Controller에서 "pageNum"으로 넘겨준 현재 페이지 번호를 가져옵니다.
    String pageNum = (String) request.getAttribute("pageNum");
%>

<body>

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center">
<br><b>글 수정</b><br><br>
<%-- action을 Controller의 updateProc.do로 변경합니다 --%>
<form action="updateProc.do?pageNum=<%=pageNum %>" method="post" name="writeForm"
onsubmit="return writeSave()">

<table width="400" border="1" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr>
    <td width="70" bgcolor="<%=value_c%>" align="center">글번호</td>
    <td width="330">
        <input type="text" name="boardno" value="<%=article.getBoardno()%>" readonly>
    </td>
</tr>

<tr>
    <td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
    <td width="330" >
        <input type="text" size="50" maxlength="50" name="title"
        value="<%=article.getTitle()%>">
    </td>
</tr>

<tr>
    <td width="70" bgcolor="<%=value_c%>" align="center">✨내용</td>
    <td width="330" >
            <textarea rows="13" cols="50" name="content"><%=article.getContent()%></textarea>
    </td>
</tr>

<tr>
    <td align="center" colspan="2" bgcolor="<%=value_c%>">
        <input type="submit" value="글수정">
        <input type="reset" value="다시작성">
        <input type="button" value="글목록"
        onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
    </td>
</tr>

</table>
</form>
</div>

</div>

</body>
</html>