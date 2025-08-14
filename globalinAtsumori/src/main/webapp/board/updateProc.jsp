<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@ page import="board.BoardDAO" %>
    <%@ page import="java.sql.Timestamp" %>

    <%
        request.setCharacterEncoding("utf-8");
    %>

    <jsp:useBean id="article" class="board.BoardVO" scope="page">
        <jsp:setProperty name="article" property="*"/>
    </jsp:useBean>

    <%
        String pageNum = request.getParameter("pageNum");
        BoardDAO dbPro = BoardDAO.getInstance();
        int check = dbPro.updateArticle(article);

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
alert("다시 수정해 주세요.");
history.go(-1);
</script>
<%} %>
</body>
</html>