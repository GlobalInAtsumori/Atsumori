<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<jsp:useBean id="dao" class="dao.MemberDAO" />

<%
    // 폼에서 넘겨받는 ID를 memberId로 받음
  String memberId = request.getParameter("memberId");


    boolean exists = false;

    // 빈 값이면 사용 가능 처리
    if (memberId != null && !memberId.trim().equals("")) {
        exists = dao.idCheck(memberId); // member 테이블 확인
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복 체크</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<br>
<div align="center">
    <% if(memberId == null || memberId.trim().equals("")) { %>
        <b>ID를 입력해주세요!</b>
    <% } else { %>
        <b><%= memberId %></b>
        <%
            if(exists){
                out.println("는 이미 존재하는 ID입니다.<br>");
            } else {
                out.println("는 사용 가능한 ID입니다.<br>");
            }
        %>
    <% } %>
    <br><br>
    <a href="#" onclick="self.close()">닫기</a>
</div>
</body>
</html>
