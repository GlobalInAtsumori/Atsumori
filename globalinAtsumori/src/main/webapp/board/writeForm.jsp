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

<%-- 이 부분의 기존 로직을 제거하거나 Controller에서 처리하도록 변경해야 합니다. --%>
<%
    int boardno = 0;
    try {
        if(request.getParameter("boardno") != null){
            boardno = Integer.parseInt(request.getParameter("boardno"));
        }
    }catch(Exception e){e.printStackTrace();}
%>

<body bgcolor="<%=bodyback_c%>">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center"><br><b>글쓰기</b></div><br>
<form action="writeProc.do" method="post" name="writeForm"
onsubmit="return writeSave()">

<table width="470" border="1" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr>
		<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="list.do">글목록</a>
		</td>
</tr>

<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
	<td width="330">
			<input type="text" size="12" maxlength="12" name="writer">
	</td>
</tr>

<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">이메일</td>
	<td width="330">
			<input type="text" size="30" maxlength="30" name="email">
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
	<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
	<td width="330">
			<input type="password" size="10" maxlength="10" name="pass">
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