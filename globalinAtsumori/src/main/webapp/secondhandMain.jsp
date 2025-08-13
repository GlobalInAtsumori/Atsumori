<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setAttribute("bannerMessage", "🛒中古品売買🛒"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>🛒中古品売買🛒</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/secondhand.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		<div class="sh-container">
			
			<div class="sh-list">
			<!-- 등록된 글 리스트 출력 예정 -->
			</div>
			
			<!-- 글쓰기 버튼 -->
			<button id="shWriteBtn" onclick="location.href='secondhandWrite'">投稿</button>
			
		</div>

	</div>
</body>
</body>
</html>