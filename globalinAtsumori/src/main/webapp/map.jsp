<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    request.setAttribute("bannerMessage", "グルメツアー");
	String mapApiKey = (String) request.getAttribute("mapApiKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<script
	src="https://maps.googleapis.com/maps/api/js?key=<%=mapApiKey%>&callback=initMap&v=weekly&libraries=marker"
	async
	defer></script>
<script src="js/map.js"></script>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/map.css">
<link rel="stylesheet" href="css/basic.css">
</head>
<body>
	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />

		<div class="map-container">
			<!-- 왼쪽: 맛집 목록 (JS에서 채움) -->
			<div class="restaurant-list" id="restaurantList">
				<!-- 목록이 여기 들어감 -->
			</div>
			
			<button id="writeReviewBtn" onclick="location.href='reviewWrite'">리뷰 쓰기</button>

			<!-- 오른쪽: 지도 -->
			<div id="map"></div>
		</div>

	</div>
</body>
</html>