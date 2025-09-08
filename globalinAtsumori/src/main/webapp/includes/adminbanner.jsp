<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/style.css">
<div class="navbar">

	<%
	String loginID = (String) session.getAttribute("loginID");
	String loginPermission = (String) session.getAttribute("loginPermission");
	String currentPage = request.getServletPath(); // 현재 JSP 파일 경로 가져오기
	%>

	<div class="adminbanner">
		<span class="label">会員管理</span> 
		<a href="memberAdmin.jsp"
			class="<%=currentPage.contains("memberAdmin.jsp") ? "active" : ""%>">権限</a>
		<a href="memberSanctions.jsp"
			class="<%=currentPage.contains("memberSanctions.jsp") ? "active" : ""%>">制裁</a>
	</div>


</div>
