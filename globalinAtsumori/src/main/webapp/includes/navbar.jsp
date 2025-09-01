<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="navbar">
<% String loginID = (String) session.getAttribute("loginID"); %>
	<div class="navbar-left">아쯔모리</div>
	<div class="navbar-center">
		<a href="test.jsp">자유 게시판</a>
		<a href="test.jsp">맛집 정보</a>
		<a href="test.jsp">중고 거래</a>
	</div>
	<div class="navbar-right">
		 <%
            if (loginID != null) {
        %>
            <span><%= loginID %>님</span>
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