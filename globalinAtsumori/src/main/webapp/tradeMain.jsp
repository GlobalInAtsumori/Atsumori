<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<% request.setAttribute("bannerMessage", "🛒中古品売買🛒"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>🛒中古品売買🛒</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/trade.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		<div class="tr-container">
			
			<div class="tr-list">
				<!-- 등록된 글 리스트 출력 -->
				<c:forEach var="post" items="${tradeList}">
					<div class="thumb">
						${post.tradePostNo} - <b>${post.tradeTitle}</b>
						<c:if test="${! empty post.thumbnailUrl}">
							<div style="width: 200px;">
								<img alt="썸네일" src="${post.thumbnailUrl}" width="100%">
							</div>
						</c:if>
						${post.cost} ${post.statusLabel} ${post.dateFormat}
					</div>
				</c:forEach>
			</div>
			
			<!-- 글쓰기 버튼 -->
			<button id="trWriteBtn" onclick="location.href='tradeWrite'">投稿</button>
			
		</div>

	</div>
</body>
</body>
</html>