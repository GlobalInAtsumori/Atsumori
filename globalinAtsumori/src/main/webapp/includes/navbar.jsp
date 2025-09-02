<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="navbar">

<% String loginID = (String) session.getAttribute("loginID"); %>
	
	<div class="navbar-left"><a href="${pageContext.request.contextPath}/">아쯔모리</a></div>

	<div class="navbar-center">
		<a href="${pageContext.request.contextPath}/board/list">자유 게시판</a>
		<a href="${pageContext.request.contextPath}/map">맛집 정보</a>
		<a href="${pageContext.request.contextPath}/tradeMain">중고 거래</a>
	</div>
	<div class="navbar-right">
		 <%
            if (loginID != null) {
        %>
            <a href="${pageContext.request.contextPath}/mypage/myPage">
			    <%= loginID %>님
			</a>
            <a href="<%= request.getContextPath() %>/memberone/logout.jsp">로그아웃</a>

        <%
            } else {
        %>
            <a href="<%= request.getContextPath() %>/memberone/regForm.jsp">회원가입</a>
            <a href="<%= request.getContextPath() %>/memberone/login.jsp">로그인</a>
        <%
            }
        %>
	</div>
</div>