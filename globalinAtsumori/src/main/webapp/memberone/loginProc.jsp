<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*, domain.MemberVO"%>
<jsp:useBean id="dao" class="dao.MemberDAO" />
<%
request.setCharacterEncoding("UTF-8");
String memberId = request.getParameter("memberId");
String password = request.getParameter("password");

int check = dao.loginCheck(memberId, password);
MemberVO vo = dao.getMember(memberId);
int memberNo = vo.getMemberNo();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<%
	if (check == 1) {
		session.setAttribute("loginID", memberId);
		session.setAttribute("memberNo", memberNo);
		response.sendRedirect("../mainPage.jsp");

	} else if (check == 0) {
	%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
	<%
	} else {
	%>
	<script>
		alert("아이디가 존재하지 않습니다.");
		history.go(-1);
	</script>
	<%
	}
	%>
</body>
</html>