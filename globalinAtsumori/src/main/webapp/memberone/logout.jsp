<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 세션 초기화
    session.invalidate();

    // 로그아웃 후 바로 메인페이지로 이동
    response.sendRedirect(request.getContextPath() + "/mainPage.jsp");
%>
