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
<title>ID重複チェック</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<br>
<div align="center">
    <% if(memberId == null || memberId.trim().equals("")) { %>
        <b>IDを入力してください！</b>
    <% } else { %>
        <b><%= memberId %></b>
        <%
            if(exists){
                out.println("は既に存在するIDです。<br>");
            } else {
                out.println("は使用可能なIDです。<br>");
            }
        %>
    <% } %>
    <br><br>
    <a href="#" onclick="self.close()">閉じる</a>
</div>
</body>
</html>
