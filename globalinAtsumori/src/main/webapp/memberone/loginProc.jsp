<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, domain.MemberVO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String memberId = request.getParameter("memberId");
    String password = request.getParameter("password");

    if(memberId == null || memberId.trim().isEmpty() || password == null || password.trim().isEmpty()) {
        out.println("<script>alert('IDとパスワードを入力してください。'); history.back();</script>");
        return;
    }

    MemberDAO dao = new MemberDAO();
    int check = dao.loginCheck(memberId, password);

    if(check == 0) {
        out.println("<script>alert('IDまたはパスワードが正しくありません。'); history.back();</script>");
        return;
    }

    MemberVO vo = dao.getMember(memberId);
    if(vo == null) {
        out.println("<script>alert('会員情報を読み込めません。'); history.back();</script>");
        return;
    }

    // 🚨 여기서 제재 상태 확인
    if ("정지".equals(vo.getSanctionStatus())) {
        out.println("<script>alert('アカウントが停止されました。 管理者にお問い合わせください。'); history.back();</script>");
        return;
    } else if ("탈퇴".equals(vo.getSanctionStatus())) {
        out.println("<script>alert('退会されたアカウントです。'); history.back();</script>");
        return;
    }

    // 로그인 성공 시 세션에 정보 저장
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
