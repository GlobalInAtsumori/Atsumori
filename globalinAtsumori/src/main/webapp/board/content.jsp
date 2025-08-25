<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dto.BoardDTO" %>
<%@ include file="color.jsp" %>

<%-- Controller가 Model에 담아준 데이터를 사용합니다 --%>
<%
	// Controller에서 "article"이라는 이름으로 넘겨준 BoardDTO 객체를 가져옵니다.
	BoardDTO article = (BoardDTO) request.getAttribute("article");
	// Controller에서 "pageNum"으로 넘겨준 현재 페이지 번호를 가져옵니다.
	String pageNum = (String) request.getAttribute("pageNum");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body bgcolor="<%=bodyback_c%>">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center">
<br><b>글 상세 보기</b><br><br>
<form action="">


<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글번호</td>
		<td align="center" width="30%"><%=article.getBoardno() %></td>
		
		<td align="center" width="20%" bgcolor="<%=value_c%>">조회수</td>
		<td align="center" width="30%">1</td> </tr>


<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">작성자</td>
		<td align="center" width="30%"><%=article.getMemberno() %></td> <td align="center" width="20%" bgcolor="<%=value_c%>">작성일</td>
		<td align="center" width="30%">
		<%=article.getCreatedate()%></td>
</tr>
</table>

<br>

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글제목</td>
		<td align="center" width="375" colspan="3">
		<%=article.getTitle() %></td>
</tr>


<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글내용</td>
		<td align="left" width="375" colspan="3">
			<pre><%=article.getContent() %></pre>
		</td>
</tr>
</table>

<br>

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">


<tr height="30">
	<td colspan="4" bgcolor="<%=value_c%>" align="right">
	
		<%
			String loginID = (String) session.getAttribute("loginID"); //로그인 여부 확인
			if (loginID == null) {
		%>
		
			<input type="button" value="글수정"
				onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='<%=request.getContextPath()%>/member/login.jsp';">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제"
				onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='<%=request.getContextPath()%>/member/login.jsp';">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="답변글작성"
				onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='<%=request.getContextPath()%>/member/login.jsp';">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
		<%
			} else {
		%>
		
			<input type="button" value="글수정"
				onclick="document.location.href='updateForm.do?boardno=<%=article.getBoardno()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제"
				onclick="document.location.href='deleteForm.do?boardno=<%=article.getBoardno()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="답변글작성"
				onclick="document.location.href='writeForm.do?boardno=<%=article.getBoardno()%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
		<%
			}
		%>
		<input type="button" value="글목록"
			onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
	</td>
</tr>
</table>
</div>

</div>
</body>
</html>
