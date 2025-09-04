<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">

    <%
        String loginID = (String) session.getAttribute("loginID");
        String loginPermission = (String) session.getAttribute("loginPermission");
        String currentPage = request.getServletPath(); // 현재 JSP 파일 경로 가져오기
    %>
    
    <% if("/memberAdmin.jsp".equals(currentPage) || "/memberSanctions.jsp".equals(currentPage)) { %>
        <link rel="stylesheet" href="/css/style.css">
        <div class="adminbanner">
            <span class="label">회원관리</span>
            <a href="memberAdmin.jsp">권한</a>
            <a href="memberSanctions.jsp">제재</a>
        </div>
    <% } else if("/adminBoard.jsp".equals(currentPage) || "/adminComment.jsp".equals(currentPage)) { %>
        <div class="adminbanner">
            <span class="label">글 관리</span>
            <a href="adminBoard.jsp">게시글</a>
            <a href="adminComment.jsp">댓글</a>
        </div>
    <% } %>

</div>
