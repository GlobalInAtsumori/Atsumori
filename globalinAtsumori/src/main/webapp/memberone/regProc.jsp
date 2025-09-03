<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, domain.MemberVO" %>
<%
    request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

    // 1️⃣ DAO 객체 생성
    MemberDAO dao = new MemberDAO();

    // 2️⃣ 폼에서 입력받은 값 가져오기
    String name = request.getParameter("memberName").trim();
    String memberId = request.getParameter("memberId").trim();
    String password = request.getParameter("password").trim();
    String country = request.getParameter("country").trim();
    String emailId = request.getParameter("email").trim();
    String emailDomain = request.getParameter("emailDomain");

    if("직접입력".equals(emailDomain)) {
        emailDomain = request.getParameter("emailDomainCustom").trim();
    }

    // 3️⃣ 이메일 처리: 이미 @가 포함되어 있으면 그대로, 아니면 @domain 붙임
    String email;
    if(emailId.contains("@")) {
        email = emailId; // 사용자가 abc1234@naver.com 입력했으면 그대로 사용
    } else {
        email = emailId + "@" + emailDomain; // 일반 처리
    }

    // 4️⃣ VO 생성
    MemberVO vo = new MemberVO();
    vo.setMemberName(name);
    vo.setMemberId(memberId);
    vo.setPassword(password);
    vo.setCountry(country);
    vo.setEmail(email);

    // 5️⃣ ID 중복 체크
    if(dao.idCheck(memberId)){
        out.println("<script>alert('이미 존재하는 ID입니다.'); history.back();</script>");
        return; // 중복이면 뒤로 돌아감
    }

    // 6️⃣ 회원가입
    dao.insertMember(vo);
    out.println("<script>alert('회원가입 성공'); location.href='login.jsp';</script>");
%>
