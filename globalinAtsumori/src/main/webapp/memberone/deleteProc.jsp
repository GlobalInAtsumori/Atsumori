<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String memberId = (String) session.getAttribute("loginID");
    String password = request.getParameter("password");

    if(memberId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='index.jsp';</script>");
        return;
    }

    MemberDAO dao = new MemberDAO();
    boolean result = dao.deleteMember(memberId, password);

    if(result) {
        session.invalidate();
%>
<script>
    alert("회원탈퇴가 완료 되었습니다.");
    location.href='<%=request.getContextPath()%>/mainPage.jsp';
</script>

<%
    } else {
%>
<script>
    alert("비밀번호가 맞지 않거나 회원 탈퇴에 실패했습니다.");
    history.back();
</script>
<% } %>
