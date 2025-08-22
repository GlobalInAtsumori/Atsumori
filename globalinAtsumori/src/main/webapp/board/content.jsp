<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>

<%@ page import="board.BoardDAO" %>		<%-- 게시판 데이터 처리하는 클래스 임포트 --%>
<%@ page import="board.BoardVO" %>		<%-- 게시글 데이터 저장용 클래스 임포트 --%>
<%@ page import="java.util.List" %>						<%-- 여러 개의 게시글을 담기 위한 리스트 --%>
<%@ page import="java.text.SimpleDateFormat" %>	<%-- 날짜 형식 변환용 클래스 --%>
<%@ include file="color.jsp" %>						<%-- 색상값을 담은 JSP 파일 포함 --%>

<%

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	try {
		BoardDAO dbPro = BoardDAO.getInstance();
		BoardVO article = dbPro.getArticle(num);
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();

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


<table width="500" border="2" cellpadding="0" cellpacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글번호</td>
		<td align="center" width="30%"><%=article.getNum() %></td>
		
		<td align="center" width="20%" bgcolor="<%=value_c%>">조회수</td>
		<td align="center" width="30%"><%=article.getReadcount() %></td>
</tr>


<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">작성자</td>
		<td align="center" width="30%"><%=article.getWriter() %></td>
		
		<td align="center" width="20%" bgcolor="<%=value_c%>">작성일</td>
		<td align="center" width="30%">
		<%=sdf.format(article.getRegdate()) %></td>
</tr>
</table>

<br>		<%-- 간격 띄우기 --%>

<table width="500" border="2" cellpadding="0" cellpacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글제목</td>
		<td align="center" width="375" colspan="3">
		<%=article.getSubject() %></td>
</tr>


<tr height="30">
		<td align="center" width="20%" bgcolor="<%=value_c%>">글내용</td>
		<td align="left" width="375" colspan="3">
			<pre><%=article.getContent() %></pre>
		</td>
</tr>
</table>

<br>			<%-- 간격 띄우기 --%>

<table width="500" border="2" cellpadding="0" cellpacing="0"
align="center" bgcolor="<%=bodyback_c%>">


<%--로그인 상태일 경우 글수정, 글삭제, 답변글작성 가능. 로그인 상태가 아니면 로그인부터 해야함  --%>
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
				onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제" 
				onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="답변글작성"
				onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&step=<%=step%>&depth=<%=depth%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
		<%
			}
		%>
		<input type="button" value="글목록" 
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
	</td>
</tr>

<%--
<tr height="30">
	<td colspan="4" bgcolor="<%=value_c%>" align="right">
			<input type="button" value="글수정" 
			onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="글삭제" 
			onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
			<input type="button" value="답변글작성"
			onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&step=<%=step%>&depth=<%=depth%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
			<input type="button" value="글목록" 
			onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
			
	</td>
</tr>
--%>
</table>
	<%}catch(Exception e){e.printStackTrace();} %>

</form>


</div>

</div>
</body>
</html>