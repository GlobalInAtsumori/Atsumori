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
<link rel="stylesheet" href="css/tradeDetail.css">
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
					<div class="imgBox"><img alt="image" src="${post.thumbnailUrl}"></div>
					<ul>
						<li class="date">${post.dateFormat}</li>
						<li class="title">${post.tradeTitle}</li>
						<li class="memberName">${post.memberName}</li>
						<li class="costTitle">値段</li>
						<li class="cost">${post.cost}</li>
						<li><button class="tradeBtn ${post.tradeBtnClass}" ${post.tradeBtnEnabled ? "" : "disabled"}>${post.tradeBtnLabel}</button></li>
					</ul>
				</div>
				
				<!-- 상세설명 -->
				<div class="trdBottom">
					<p class="detailTitle">詳細説明</p>
					<p class="detail">${post.tradeContent}</p>
				</div>
				
			</div>
			
			
			<!-- 버튼 출력 -->
			<button id="trList" onclick="location.href='tradeMain'">リスト</button>
			
		</div>
	</div>
</body>
</html>