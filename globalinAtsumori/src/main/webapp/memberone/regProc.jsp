<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO, domain.MemberVO" %>

<%
    // 1️⃣ DAO 객체 생성
    MemberDAO dao = new MemberDAO();

    // 2️⃣ 폼에서 입력받은 값 가져오기
    String name = request.getParameter("memberName");
    String memberId = request.getParameter("memberId");
    String password = request.getParameter("password");
    String country = request.getParameter("country");
    String emailId = request.getParameter("email");
    String emailDomain = request.getParameter("emailDomain");
    if(emailDomain.equals("직접입력")){
        emailDomain = request.getParameter("emailDomainCustom").trim();
    }
    String email = emailId + "@" + emailDomain;

    // 3️⃣ VO 생성
    MemberVO vo = new MemberVO();
    vo.setMemberName(name);
    vo.setMemberId(memberId);
    vo.setPassword(password);
    vo.setCountry(country);
    vo.setEmail(email);

    // 4️⃣ ID 중복 체크
    if(dao.idCheck(memberId)){
        out.println("<script>alert('이미 존재하는 ID입니다.'); history.back();</script>");
    } else {
        dao.insertMember(vo);
        out.println("<script>alert('회원가입 성공'); location.href='login.jsp';</script>");
    }
%>
