<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">

    <%
        String loginID = (String) session.getAttribute("loginID");
        String loginPermission = (String) session.getAttribute("loginPermission");
    %>

    <div class="navbar-left">
        <a href="<%=request.getContextPath()%>/">아쯔모리</a>
    </div>

    <div class="navbar-center">
        <a href="<%=request.getContextPath()%>/board/list">자유 게시판</a>
        <a href="<%=request.getContextPath()%>/map">맛집 정보</a>
        <a href="<%=request.getContextPath()%>/tradeMain">중고 거래</a>
    </div>

    <div class="navbar-right">
        <%
            if (loginID != null) {
        %>
            <span><%= loginID %>님</span>

            <%
                // null-safe + 대소문자 상관없이 admin 체크
                if (loginPermission != null && loginPermission.equalsIgnoreCase("admin")) {
            %>
                <a href="<%=request.getContextPath()%>/admin/dashboard.jsp">관리자</a>
            <%
                }
            %>

            <a href="<%=request.getContextPath()%>/mypage/myPage.jsp">마이페이지</a>
            <a href="<%=request.getContextPath()%>/memberone/logout.jsp">로그아웃</a>

        <%
            } else {
        %>
            <a href="<%=request.getContextPath()%>/memberone/regForm.jsp">회원가입</a>
            <a href="<%=request.getContextPath()%>/memberone/login.jsp">로그인</a>
        <%
            }
        %>
    </div>
</div>
