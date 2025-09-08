<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	session="true"%>
<%
// 세션에서 로그인 정보 가져오기
String loginID = (String) session.getAttribute("loginID");
String loginPermission = (String) session.getAttribute("loginPermission");
String currentPage = request.getServletPath(); // 현재 JSP 파일 경로 가져오기

request.setAttribute("bannerMessage", "관리자 화면");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet" href="/css/style.css">

</head>
<body>
	<div class="wrapper">
		<jsp:include page="/includes/navbar.jsp" />
		<jsp:include page="/includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		<!-- 여기까지가 상단부   이 밑으로는 페이지 내용 등등 -->
		<h1 align = "center">관리자 페이지</h1>
		
		
		   <div class="adminbanner">
		
		<a href="memberAdmin.jsp">권한</a>
		<a href="memberSanctions.jsp">제재</a>

	
		 <a href="adminBoard.jsp">게시글</a>
		<a href="adminComment.jsp">댓글</a>
	</div>


	
	</div>
</body>
</html>
