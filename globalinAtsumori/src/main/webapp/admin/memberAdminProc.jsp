<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="dao.MemberDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int memberNo = Integer.parseInt(request.getParameter("memberNo"));
    String permission = request.getParameter("permission");

    MemberDAO dao = new MemberDAO();
    int result = dao.updatePermission(memberNo, permission);

    if (result > 0) {
        out.println("<script>alert('권한이 변경되었습니다.'); location.href='memberAdmin.jsp';</script>");
    } else {
        out.println("<script>alert('권한 변경 실패'); history.back();</script>");
    }
%>
