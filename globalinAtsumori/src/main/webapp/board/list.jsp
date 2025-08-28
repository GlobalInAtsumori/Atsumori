<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% request.setAttribute("bannerMessage", "雑談掲示板"); %>

<%--
	기존에 사용하던 JSP 스크립틀릿 변수들은 EL로 대체되었으므로 주석 처리.
	<%@ page import="java.util.List"%>
	<%@ page import="dto.BoardDTO"%>
	<%@ include file="color.jsp"%>
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
		<br><b>글목록(전체 글: ${count})</b>
		<p>
		
		<table width="700" border="2" cellpadding="0" cellspacing="0">
			<tr height="30" bgcolor="${value_c}">
				<td align="center" width="50">번호</td>
				<td align="center" width="250">제목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
			</tr>
			
			<c:choose>
				<c:when test="${not empty articleList}">
					<c:set var="number" value="${count - (pageNum - 1) * pageSize}" />
					<c:forEach var="article" items="${articleList}">
						<tr height="30">
							<td align="center" width="50">${number}</td>
							<td width="250">
								<a href="content?boardno=${article.boardno}&pageNum=${pageNum}">
									${article.title}
								</a>
							</td>
							<td align="center" width="100">
								${article.memberno}
							</td>
							<td align="center" width="150">
								<fmt:formatDate value="${article.createdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
						<c:set var="number" value="${number - 1}" />
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" align="center">게시판에 저장된 글이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		
		<%-- list.jsp 파일의 페이지네이션 부분 --%>
		<c:if test="${count > 0}">
    <c:set var="pageSize" value="5"/>
    <c:set var="pageCount" value="${(count - 1) / pageSize + 1}"/>
    
    <%-- [이전] 버튼: 현재 페이지가 1보다 클 때만 표시합니다. --%>
    <c:if test="${pageNum > 1}">
        <a href="list?pageNum=${pageNum - 1}">[이전]</a>
    </c:if>

    <%-- 모든 페이지 링크를 표시합니다. --%>
    <c:forEach begin="1" end="${pageCount}" var="i">
        <c:choose>
            <%-- 현재 페이지는 링크를 제거하고 볼드체로 표시합니다. --%>
            <c:when test="${i == pageNum}">
                <b>[${i}]</b>
            </c:when>
            <%-- 그 외의 페이지는 링크를 표시합니다. --%>
            <c:otherwise>
                <a href="list?pageNum=${i}">[${i}]</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <%-- [다음] 버튼: 현재 페이지가 마지막 페이지보다 작을 때만 표시합니다. --%>
    <c:if test="${pageNum < pageCount-1}">
        <a href="list?pageNum=${pageNum + 1}">[다음]</a>
    </c:if>
</c:if>
		
		<div style="text-align: right; width: 700px; margin: 10px auto;">
		
		<c:choose>
			<c:when test="${empty sessionScope.loginID}">
				<form action="${pageContext.request.contextPath}/member/login.jsp" method="post"
					onsubmit="return alert('로그인이 되지 않았습니다. 로그인 해 주세요.');">
					<input type="submit" value="글쓰기">
				</form>
			</c:when>
			<c:otherwise>
				<form action="writeForm"> <input type="submit" value="글쓰기">
				</form>
			</c:otherwise>
		</c:choose>
			
		</div>
		
		<form action="list">
			<select name="searchWhat">
				<option value="writer" <c:if test="${searchWhat == 'writer'}">selected</c:if>>작성자</option>
				<option value="subject" <c:if test="${searchWhat == 'subject'}">selected</c:if>>제목</option>
				<option value="content" <c:if test="${searchWhat == 'content'}">selected</c:if>>내용</option>
			</select> <input type="text" name="searchText" value="${searchText}">
			<input type="submit" value="검색">
		</form>
	</div>
	
</div>
</body>
</html>