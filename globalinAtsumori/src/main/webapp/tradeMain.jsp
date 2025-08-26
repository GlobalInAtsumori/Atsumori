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
<link rel="stylesheet" href="css/tradeMain.css">
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
							<ul>
								<li class="title">${post.tradeTitle}</li>
								<li class="cost">${post.cost}</li>
								<li class="memberName">${post.memberName}</li>
							</ul>
							<p class="date">${post.dateFormat}</p>
						</div>
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