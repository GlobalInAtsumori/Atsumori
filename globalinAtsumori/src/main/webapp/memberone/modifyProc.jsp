<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="domain.MemberVO"%>

<%
    String loginID = (String) session.getAttribute("loginID");
    if (loginID == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    String password = request.getParameter("password");
    String repass = request.getParameter("repass");
    String memberName = request.getParameter("memberName");
    String email = request.getParameter("email");
    
    if (password != null && !password.equals(repass)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    MemberDAO dao = new MemberDAO();
    MemberVO dbVo = dao.getMember(loginID);

    if (dbVo == null) {
        out.println("<script>alert('회원 정보를 불러올 수 없습니다.'); location.href='login.jsp';</script>");
        return;
    }

    // 업데이트할 정보 세팅
    MemberVO vo = new MemberVO();
    vo.setMemberNo(dbVo.getMemberNo()); // PK
    vo.setMemberId(dbVo.getMemberId()); // ID는 바뀌지 않음
    vo.setMemberName(memberName != null && !memberName.trim().isEmpty() ? memberName : dbVo.getMemberName());
    vo.setPassword(password != null && !password.trim().isEmpty() ? password : dbVo.getPassword());
    vo.setEmail(email != null && !email.trim().isEmpty() ? email : dbVo.getEmail());
    vo.setCountry(dbVo.getCountry()); // 국가가 form에 없으면 기존값 유지

    int result = dao.updateMember(vo);

    if (result > 0) {
        out.println("<script>alert('회원 정보가 수정되었습니다.'); location.href='" + request.getContextPath() + "/mypage/myPage.jsp';</script>");
    } else {
        out.println("<script>alert('회원 정보 수정에 실패했습니다.'); history.back();</script>");
    }
%>