<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.sql.*" %>		<%-- 필요한 패키지 임포트: BoardVO, BoardDAO, Timestamp 등 --%>
    
<% request.setCharacterEncoding("utf-8"); %>			<%-- POST 방식으로 전달된 한글 데이터를 올바르게 처리하기 위해 인코딩 설정 --%>
    
    
<%-- ★ JSP의 useBean 태그를 사용해 BoardVO 객체 생성 및 자동 데이터 매핑 - form(name 속성 일치)의 각 입력값들이 BoardVO 클래스의 setXXX 메서드로 자동 연결됨  --%>
<jsp:useBean id="article" class="board.BoardVO" scope="page">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>
    
    <%
    	// 현재 시간 정보를 등록일자로 저장
    	article.setRegdate(new Timestamp(System.currentTimeMillis()));
    
 		// 글 작성자의 IP 주소 저장
    	article.setIp(request.getRemoteAddr());
    	
        // DAO 인스턴스를 얻어와서 글을 DB에 저장하는 메서드 호출
    	BoardDAO dbPro = BoardDAO.getInstance();
    	dbPro.insertArticle(article);    			// 이 메서드는 사용자가 직접 DAO에 구현해야 함
    	
        // 저장 완료 후 게시판 목록 페이지로 리다이렉트
    	response.sendRedirect("list.jsp");
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>						<%-- 화면에 보이는 내용은 없지만 기본 구조를 위해 작성 --%>
</head>
<body>

</body>
</html>