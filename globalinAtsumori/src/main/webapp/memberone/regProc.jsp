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

    // 3️⃣ 이메일 처리
    String email;
    if(emailId.contains("@")) {
        email = emailId;
    } else {
        email = emailId + "@" + emailDomain;
    }

    // 4️⃣ VO 생성
    MemberVO vo = new MemberVO();
    vo.setMemberName(name);
    vo.setMemberId(memberId);
    vo.setPassword(password);
    vo.setCountry(country);
    vo.setEmail(email);

    // 🔹 permission 기본값 안전하게 설정
    String permission = request.getParameter("permission"); // 폼에서 가져올 수도 있음
    if(permission == null || permission.isEmpty()) {
        permission = "user"; // 기본값
    }
    vo.setPermission(permission);

    // 5️⃣ ID 중복 체크
    if(dao.idCheck(memberId)){
        out.println("<script>alert('이미 존재하는 ID입니다.'); history.back();</script>");
        return;
    }

    // 6️⃣ 회원가입
    dao.insertMember(vo);

    /* // 7️⃣ 회원가입 성공 후 바로 로그인 처리
    session.setAttribute("loginID", memberId);
    session.setAttribute("memberName", name);

    out.println("<script>alert('회원가입 성공'); location.href='" + request.getContextPath() + "/mainPage.jsp';</script>"); */
    
 // 6️⃣ 회원가입
    dao.insertMember(vo);

    // 회원가입 성공 후 로그인 화면으로 이동
    out.println("<script>alert('회원가입 성공! 로그인 해주세요.'); location.href='" + request.getContextPath() + "/memberone/login.jsp';</script>");
%>
