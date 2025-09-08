<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String memberId = (String) session.getAttribute("loginID");
    String password = request.getParameter("password");

    if(memberId == null) {
        out.println("<script>alert('ログインが必要です。'); location.href='index.jsp';</script>");
        return;
    }

    MemberDAO dao = new MemberDAO();
    boolean result = dao.deleteMember(memberId, password);

    if(result) {
        session.invalidate();
%>
<script>
    alert("会員退会が完了しました。");
    location.href='<%=request.getContextPath()%>/mainPage.jsp';
</script>

<%
    } else {
%>
<script>
    alert("パスワードが正しくないか、会員退会に失敗しました。");
    history.back();
</script>
<% } %>
