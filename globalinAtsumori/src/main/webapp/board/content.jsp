<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>

<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dto.BoardDTO" %>
<%@ include file="color.jsp" %>

<%
	BoardDTO article = (BoardDTO) request.getAttribute("article");
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

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

<tr height="30">
	<td align="center" width="20%" bgcolor="<%=value_c%>">글번호</td>
	<td align="center" width="30%"><%=article.getBoardno() %></td>
	<td align="center" width="375" bgcolor="<%=value_c%>">작성일</td>
	<td align="center" width="375"><%=article.getCreatedate()%></td>
</tr>
<tr height="30">
	<td align="center" width="20%" bgcolor="<%=value_c%>">작성자</td>
	<td align="center" width="30%"><%=article.getMemberno() %></td>
	<td align="center" width="20%" bgcolor="<%=value_c%>">조회수</td>
	<td align="center" width="30%">1</td>
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
	<td colspan="4" bgcolor="<%=value_c%>" align="center">
		<%
			String loginID = (String) session.getAttribute("loginID");
			if (loginID == null) {
		%>
		<input type="button" value="글수정"
			onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='<%=request.getContextPath()%>/member/login.jsp';">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글삭제"
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
		<%
			}
		%>
		<input type="button" value="글목록"
			onclick="document.location.href='list.do?pageNum=<%=pageNum%>'">
	</td>
</tr>
</table>

<br>
<div style="width: 500px; margin: 0 auto; text-align: left;">
    <h4 style="border-bottom: 2px solid #ccc; padding-bottom: 5px;">댓글</h4>

    <c:if test="${not empty sessionScope.loginID}">
        <form action="addComment.do" method="post">
          	<input type="hidden" name="boardNo" value="${article.boardno}">
  		  	<input type="hidden" name="pageNum" value="<%=pageNum%>">
    		<textarea name="content" rows="3" cols="60" placeholder="댓글을 입력하세요." required></textarea>
    		<br>
    		<input type="submit" value="댓글 작성">
		</form>
    </c:if>
    <c:if test="${empty sessionScope.loginID}">
        <p>댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a>해주세요.</p>
    </c:if>

    <c:forEach var="comment" items="${commentList}">
        <div style="border: 1px solid #ccc; padding: 10px; margin-top: 10px; border-radius: 5px;">
            <p><strong>${comment.memberName}</strong> <small>(${comment.createDate})</small></p>
            <p>${comment.content}</p>
            <c:if test="${sessionScope.loginID == comment.memberId}">
                <form action="deleteComment.do" method="post" style="display:inline;">
                    <input type="hidden" name="commentNo" value="${comment.commentNo}">
                    <input type="hidden" name="boardNo" value="${comment.boardNo}">
                    <input type="hidden" name="pageNum" value="${pageNum}">
                    <input type="submit" value="삭제" onclick="return confirm('정말로 삭제하시겠습니까?');">
                </form>
            </c:if>
        </div>
    </c:forEach>
    <c:if test="${empty commentList}">
        <p>작성된 댓글이 없습니다.</p>
    </c:if>
</div>
</div>
</body>
</html>