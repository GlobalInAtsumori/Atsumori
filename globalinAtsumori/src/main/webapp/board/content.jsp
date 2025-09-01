<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% request.setAttribute("bannerMessage", "雑談掲示板"); %>

<%-- JSTL/EL로 대체되었으므로 JSP 스크립틀릿 부분은 제거하거나 주석 처리합니다. --%>
<%--
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dto.BoardDTO" %>
<%@ include file="color.jsp" %>
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body bgcolor="${bodyback_c}">

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center">
<br><b>글 상세 보기</b><br><br>

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="${bodyback_c}">

<tr height="30">
	<td align="center" width="15%" bgcolor="${value_c}">글번호</td>
	<td align="center" width="35%">${article.getBoardno() }</td>
	<td align="center" width="15%" bgcolor="${value_c}">작성일</td>
	<td align="center" width="35%">
		<fmt:formatDate value="${article.createdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</td>
</tr>
<tr height="30">
	<td align="center" width="15%" bgcolor="${value_c}">작성자</td>
	<td align="center" width="35%">${article.getMemberName() }</td>
	<td align="center" width="375" colspan="2"></td>
</tr>


<%-- <tr height="30">
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
</tr> --%>
</table>


<br>

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="${bodyback_c}">

<tr height="30">
	<td align="center" width="15%" bgcolor="${value_c}">글제목</td>
	<td align="left" width="375" colspan="3">
	${article.title}</td>
</tr>

<tr height="30">
	<td align="center" width="15%" bgcolor="${value_c}">글내용</td>
	<td align="left" width="375" colspan="3">
		<p style="white-space: pre-wrap;">${article.content}</p>
	</td>
</tr>
</table>

<br>

<table width="500" border="2" cellpadding="0" cellspacing="0"
align="center" bgcolor="${bodyback_c}">

<tr height="30">
	<td colspan="4" bgcolor="${value_c}" align="center">
		<c:choose>
			<c:when test="${not empty sessionScope.loginID}">
				<input type="button" value="글수정"
					onclick="document.location.href='updateForm?boardno=${article.boardno}&pageNum=${pageNum}'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제"
					onclick="document.location.href='deleteForm?boardno=${article.boardno}&pageNum=${pageNum}'">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</c:when>
			<c:otherwise>
				<input type="button" value="글수정"
					onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='${pageContext.request.contextPath}/memberone/login.jsp';">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제"
					onclick="alert('로그인이 되지 않았습니다. 로그인 해 주세요.'); location.href='${pageContext.request.contextPath}/memberone/login.jsp';">
				&nbsp;&nbsp;&nbsp;&nbsp;
			</c:otherwise>
		</c:choose>
		
		<input type="button" value="글목록"
			onclick="document.location.href='list?pageNum=${pageNum}'">
	</td>
</tr>
</table>

<br>
<div style="width: 500px; margin: 0 auto; text-align: left;">
    <h4 style="border-bottom: 2px solid #ccc; padding-bottom: 5px; margin-bottom: 0;">댓글</h4>

    <c:forEach var="comment" items="${commentList}">
    <%-- padding과 margin-top 값을 줄여서 공간을 줄였습니다. --%>
    <div style="border: 2px solid #ccc; padding: 5px; margin-top: 5px; border-radius: 5px;">
        <p><strong>${comment.memberName}</strong> 
            <small>(<fmt:formatDate value="${comment.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>)</small>
        </p>
        <p style="white-space: pre-wrap;">${comment.content}</p>
        
        <%-- <c:if test="${not empty sessionScope.loginID and sessionScope.loginID == comment.memberId}"> --%>
            <div align="right">
                <form action="deleteComment" method="post" style="display:inline;">
                    <input type="hidden" name="commentNo" value="${comment.commentNo}">
                    <input type="hidden" name="boardNo" value="${comment.boardNo}">
                    <input type="hidden" name="pageNum" value="${pageNum}">
                    <input type="submit" value="삭제" onclick="return confirm('정말로 삭제하시겠습니까?');">
                </form>
            </div>
        <%-- </c:if> --%>
    </div>
	</c:forEach>

    <c:if test="${empty commentList}">
        <p>작성된 댓글이 없습니다.</p>
    </c:if>


	<%-- 댓글 입력란 --%>
	<c:if test="${not empty sessionScope.loginID}">
        <form action="addComment" method="post" style="display: flex; flex-direction: column; align-items: flex-end;">
          	<input type="hidden" name="boardNo" value="${article.boardno}">
  		  	<input type="hidden" name="pageNum" value="${pageNum}">
    		<textarea name="content" rows="3" cols="68" placeholder="댓글을 입력하세요." required></textarea>
    		
    		<input type="submit" value="댓글 작성">
			<br><br>
		</form>
    </c:if>
    <c:if test="${empty sessionScope.loginID}">
        <p>댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a>해주세요.</p>
    </c:if>



</div>
</div>
</body>
</html>