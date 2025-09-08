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
<title>雑談掲示板</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
	<%-- 모든 a 태그의 밑줄을 제거 --%>
	a {text-decoration: none;}
</style>

</head>
<body bgcolor="${bodyback_c}">
<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

	<div align="center">
		<br><b>投稿一覧(全体投稿： ${count})</b>
		<p>
		
		<table width="700" border="2" cellpadding="0" cellspacing="0">
			<tr height="30" bgcolor="${value_c}">
				<td align="center" width="50">番号</td>
				<td align="center" width="250">タイトル</td>
				<td align="center" width="100">作成者</td>
				<td align="center" width="150">作成日</td>
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
								${article.memberName}
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
						<td colspan="4" align="center">この掲示板には投稿がありません。</td>
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
        <a href="list?pageNum=${pageNum - 1}">[前へ]</a>
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
        <a href="list?pageNum=${pageNum + 1}">[次へ]</a>
    </c:if>
</c:if>
		
		<div style="text-align: right; width: 700px; margin: 10px auto;">
		
		<c:choose>
    		<c:when test="${empty sessionScope.loginID}">
        		<form action="${pageContext.request.contextPath}/memberone/login.jsp" method="post"
            	onsubmit="return alert('ログインされていません。ログインしてください。');">
            		<input type="submit" value="新規登録">
        		</form>
    		</c:when>
    		<c:otherwise>
        		<form action="writeForm"> <input type="submit" value="新規投稿"></form>
    		</c:otherwise>
		</c:choose>
			
		</div>
		
		<form action="list">
			<select name="searchWhat">
				<option value="writer" <c:if test="${searchWhat == 'writer'}">selected</c:if>>作成者</option>
				<option value="subject" <c:if test="${searchWhat == 'subject'}">selected</c:if>>タイトル</option>
				<option value="content" <c:if test="${searchWhat == 'content'}">selected</c:if>>内容</option>
			</select> <input type="text" name="searchText" value="${searchText}">
			<input type="submit" value="検索">
		</form>
	</div>
	
</div>
</body>
</html>