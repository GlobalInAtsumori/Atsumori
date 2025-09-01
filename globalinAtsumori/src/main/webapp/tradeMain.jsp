<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<% request.setAttribute("bannerMessage", "🛒中古品売買🛒"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>🛒中古品売買🛒</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/trade.css">
<link rel="stylesheet" href="css/tradeMain.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		<div class="tr-container">
			
			<!-- 검색 -->
			<div class="search">
				<form action="tradeMain" method="get">
					<select name="type">
						<option value="title" ${type == 'title' ? 'selected' : ''}>タイトル</option>
						<option value="content" ${type == 'content' ? 'selected' : ''}>内容</option>
						<option value="member" ${type == 'member' ? 'selected' : ''}>投稿者</option>
					</select>
					<input type="text" name="keyword" value="${keyword}">
					<input type="submit" value="🔍" class="check">
				</form>
			</div>
			
			<!-- 등록된 글 리스트 출력 -->
			<div class="tr-list">
			<c:choose>
				<c:when test="${empty tradeList}">
				<!-- 글이 없을 경우 -->
					<p class="nopost"> </p>
					<p class="nopost">まだ投稿がありません。</p>
				</c:when>
				<c:otherwise>
				<!-- 글이 있을 경우 -->
					<c:forEach var="post" items="${tradeList}">
						<div class="thumb" onclick="location.href='tradeDetail?tradePostNo=${post.tradePostNo}'">
							<div class="thumbTop">					
								<p class="postNo">${post.rn}</p>
								<div class="status ${post.tradeBtnClass}">${post.statusLabel}</div>
							</div>
							<c:if test="${! empty post.thumbnailUrl}">
								<div class="imgBox">
									<img alt="썸네일" src="${post.thumbnailUrl}">
								</div>
							</c:if>
							<div class="thumbBottom">
								<p class="title">${post.tradeTitle}</p>
								<div class="tbBox">
									<ul>
										<li class="cost"><fmt:formatNumber value="${post.cost}" type="number" groupingUsed="true"/></li>
										<li class="memberName">${post.memberName}</li>
									</ul>
									<p class="date">${post.dateFormat}</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
			
			<!-- 페이징 -->
			<div class="pagination">
    			<c:if test="${currentPage > 1}">
					<c:choose>
						<c:when test="${not empty keyword}">
							<a href="tradeMain?page=1&type=${type}&keyword=${keyword}" class="fl">«</a>
							<a href="tradeMain?page=${currentPage - 1}&type=${type}&keyword=${keyword}" class="prev">‹ 前へ</a>			
						</c:when>
						<c:otherwise>    				
							<a href="tradeMain?page=1" class="fl">«</a>
							<a href="tradeMain?page=${currentPage - 1}" class="prev">‹ 前へ</a>			
						</c:otherwise>
					</c:choose>
				</c:if>
  				
				<c:forEach begin="${startPage}" end="${endPage}" var="p">
					<c:choose>
						<c:when test="${p == currentPage}">
							<span class="num current">${p}</span>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${not empty keyword}">
									<a href="tradeMain?page=${p}&type=${type}&keyword=${keyword}" class="num">${p}</a>
								</c:when>
								<c:otherwise>
									<a href="tradeMain?page=${p}" class="num">${p}</a>    						
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
    			
				<c:if test="${currentPage < totalPages}">
					<c:choose>
						<c:when test="${not empty keyword}">
							<a href="tradeMain?page=${currentPage + 1}&type=${type}&keyword=${keyword}" class="next">次へ ›</a>
							<a href="tradeMain?page=${totalPages}&type=${type}&keyword=${keyword}" class="fl">»</a>
						</c:when>
						<c:otherwise>
							<a href="tradeMain?page=${currentPage + 1}" class="next">次へ ›</a>
							<a href="tradeMain?page=${totalPages}" class="fl">»</a>						
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
			
			<!-- 글쓰기 버튼 -->
			<button id="trWriteBtn" onclick="location.href='tradeWrite'">投稿</button>
			
		</div>

	</div>
</body>
</body>
</html>