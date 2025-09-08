<%@ page import="dao.MemberDAO" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

int memberNo = Integer.parseInt(request.getParameter("memberNo"));
String permission = request.getParameter("permission");

MemberDAO dao = new MemberDAO();
int result = 0;

if(permission != null) {
    dao.updatePermission(memberNo, permission);
    result = 1; // 성공 처리
}

if (result > 0) {
    out.println("<script>alert('회원 정보가 정상적으로 변경되었습니다.'); location.href='memberSanctions.jsp';</script>");
} else {
    out.println("<script>alert('변경에 실패했습니다.'); history.back();</script>");
}

%>
