<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("bannerMessage", "🛍️中古品売買🛍️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.tradeTitle}</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		<div class="trd-container">
			
			<!-- 상세 내용 출력 -->
			<div class="trd-content">
				<!-- 사진 & 등록일자, 제목, 가격, 거래희망 버튼 -->
				<div class="trdTop">
					<div class="imgBox"><img alt="" src=""></div>
					<ul>
						<li class="date"></li>
						<li class="title"></li>
						<li class="costTitle"></li>
						<li class="cost"></li>
						<li><button class="tradeBtn"></button></li>
					</ul>
				</div>
				
				<!-- 상세설명 -->
				<div class="trdBottom">
					<p class="detailTitle"></p>
					<p class="detail"></p>
				</div>
				
			</div>
			
			
			<!-- 버튼 출력 -->
			<button id="trList" onclick="location.href='tradeMain'">목록</button>
			
		</div>
	</div>
</body>
</html>