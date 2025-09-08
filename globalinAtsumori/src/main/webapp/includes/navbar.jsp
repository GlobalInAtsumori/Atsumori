<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">

    <%
        String loginID = (String) session.getAttribute("loginID");
        String loginPermission = (String) session.getAttribute("loginPermission");
    %>

    <div class="navbar-left">
        <a href="<%=request.getContextPath()%>/">アツモリ</a>
    </div>

    <div class="navbar-center">
        <a href="<%=request.getContextPath()%>/board/list">雑談掲示板</a>
        <a href="<%=request.getContextPath()%>/map">グルメツアー</a>
        <a href="<%=request.getContextPath()%>/tradeMain">中古品売買</a>
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
                <a href="<%=request.getContextPath()%>/admin/dashboard.jsp">管理者</a>
            <%
                }
            %>

            <a href="<%=request.getContextPath()%>/mypage/myPage.jsp">マイページ</a>
            <a href="<%=request.getContextPath()%>/memberone/logout.jsp">logout</a>

        <%
            } else {
        %>
            <a href="<%=request.getContextPath()%>/memberone/regForm.jsp">会員登録</a>
            <a href="<%=request.getContextPath()%>/memberone/login.jsp">login</a>
        <%
            }
        %>
    </div>
</div>
