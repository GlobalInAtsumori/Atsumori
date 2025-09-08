<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>


<%
request.setCharacterEncoding("UTF-8");

int memberNo = Integer.parseInt(request.getParameter("memberNo"));
String sanctionStatus = request.getParameter("sanction_status");

MemberDAO dao = new MemberDAO();

if ("無し".equals(sanctionStatus)) {
	dao.updateSanction(memberNo, "無し");
} else if ("停止".equals(sanctionStatus)) {
	dao.updateSanction(memberNo, "停止");
} else if ("脱退".equals(sanctionStatus)) {
	dao.deleteMemberCompletely(memberNo); // 실제 삭제
}

response.sendRedirect("memberSanctions.jsp");
%>
