<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>


<%
request.setCharacterEncoding("UTF-8");

int memberNo = Integer.parseInt(request.getParameter("memberNo"));
String sanctionStatus = request.getParameter("sanction_status");

MemberDAO dao = new MemberDAO();

if ("없음".equals(sanctionStatus)) {
	dao.updateSanction(memberNo, "없음");
} else if ("정지".equals(sanctionStatus)) {
	dao.updateSanction(memberNo, "정지");
} else if ("탈퇴".equals(sanctionStatus)) {
	dao.deleteMemberCompletely(memberNo); // 실제 삭제
}

response.sendRedirect("memberSanctions.jsp");
%>
