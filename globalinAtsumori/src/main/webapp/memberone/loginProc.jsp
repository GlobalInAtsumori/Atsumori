<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, domain.MemberVO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String memberId = request.getParameter("memberId");
    String password = request.getParameter("password");

    if(memberId == null || memberId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
        out.println("<script>alert('아이디와 비밀번호를 입력해주세요.'); history.back();</script>");
        return;
    }

    MemberDAO dao = new MemberDAO();
    int check = dao.loginCheck(memberId, password);

    if(check == 0) {
        out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); history.back();</script>");
        return;
    }

    MemberVO vo = dao.getMember(memberId);
    if(vo == null) {
        out.println("<script>alert('회원 정보를 불러올 수 없습니다.'); history.back();</script>");
        return;
    }

    // 로그인 성공 시 세션에 정보 저장 (null-safe, 대소문자 상관없이 admin 체크)
    session.setAttribute("loginID", vo.getMemberId());
    session.setAttribute("memberNo", vo.getMemberNo());
    session.setAttribute("memberName", vo.getMemberName());

    // permission이 null이면 기본 'user'로 설정
    String permission = vo.getPermission();
    if(permission == null || permission.trim().isEmpty()) {
        permission = "user";
    }
    session.setAttribute("loginPermission", permission); // navbar에서 admin 버튼 확인용

    // 메인 페이지로 이동
    response.sendRedirect(request.getContextPath() + "../mainPage.jsp");
%>
