<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="board.BoardDAO" %>
    
<%
        request.setCharacterEncoding("utf-8");

        int num = Integer.parseInt(request.getParameter("num"));
         String pass = request.getParameter("pass");

        String pageNum = request.getParameter("pageNum");
        BoardDAO dbPro = BoardDAO.getInstance();
        int check = dbPro.deleteArticle(num, pass);

        if(check == 1){
            System.out.print("체크가 1일 때");
    %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta http-equiv="refresh" content="0;url=list.jsp?pageNum=<%=pageNum%>">
</head>
<body>
<%}else { %>
System.out.print("체크 1아닐 때");
<script type="text/javascript">
alert("비밀번호를 입력해 주세요.");
history.go(-1);
</script>
<%} %>
</body>
</html>