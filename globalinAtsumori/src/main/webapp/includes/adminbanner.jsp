<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/style.css">
<div class="navbar">

	<%
	String loginID = (String) session.getAttribute("loginID");
	String loginPermission = (String) session.getAttribute("loginPermission");
	String currentPage = request.getServletPath(); // 현재 JSP 파일 경로 가져오기
	%>

	<div class="adminbanner">
		<span class="label">회원관리</span> 
		<a href="memberAdmin.jsp"
			class="<%=currentPage.contains("memberAdmin.jsp") ? "active" : ""%>">권한</a>
		<a href="memberSanctions.jsp"
			class="<%=currentPage.contains("memberSanctions.jsp") ? "active" : ""%>">제재</a>
	</div>


</div>
