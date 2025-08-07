<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  request.setCharacterEncoding("UTF-8");

  String memberName = request.getParameter("memberName");
  String memberId = request.getParameter("memberId");
  String password = request.getParameter("password");
  String emailId = request.getParameter("emailId");
  String emailDomain = request.getParameter("emailDomain");
  String country = request.getParameter("country");

  String email = emailId + "@" + emailDomain;

  Connection conn = null;
  PreparedStatement pstmt = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      String url = "jdbc:mysql://localhost:3306/your_db_name?useUnicode=true&characterEncoding=UTF-8";
      String dbUser = "your_db_user";
      String dbPass = "your_db_password";
      conn = DriverManager.getConnection(url, dbUser, dbPass);

      String sql = "INSERT INTO member (memberName, memberId, password, email, country) VALUES (?, ?, ?, ?, ?)";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, memberName);
      pstmt.setString(2, memberId);
      pstmt.setString(3, password);
      pstmt.setString(4, email);
      pstmt.setString(5, country);

      int result = pstmt.executeUpdate();

      if (result > 0) {
%>
        <script>
          alert("회원가입이 완료되었습니다!");
          location.href = "login.jsp";
        </script>
<%
      } else {
%>
        <script>
          alert("회원가입에 실패했습니다.");
          history.back();
        </script>
<%
      }

  } catch (Exception e) {
    e.printStackTrace();
%>
    <script>
      alert("에러 발생: <%= e.getMessage() %>");
      history.back();
    </script>
<%
  } finally {
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
  }
%>
