<%-- 이 페이지는 필요없을 수도 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.*, domain.*, java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="shArticle" class="domain.SecondhandVO" scope="page">
	<jsp:setProperty name="shArticle" property="*" />
</jsp:useBean>

<%
	/*
	아직 로그인 기능이 구현되지 않아서 임시로 작성함
	로그인 유저 정보 확인용 코드(작동x)
	MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
	if(loginUser == null ) {
		response.sendRedirect("login.jsp");
		return;
	}
	
	
	로그인 사용자의 memberNo를 SecondhandVO에 설정함
	shArticle.setMemberNo(loginUser.getMemberNo());
	*/
	
	//테스트용 하드코딩
	shArticle.setMemberNo(4);
	
	//글 등록 날짜
	shArticle.setCreateDate(new Timestamp(System.currentTimeMillis()));
	
	//DAO를 통해 DB에 저장함
	SecondhandDAO dbSHPro = SecondhandDAO.getInstance();
	dbSHPro.insertSHArticle(shArticle);
	
	//등록 완료하면 중고거래 메인 페이지로 이동함
	response.sendRedirect("secondhandMain.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>