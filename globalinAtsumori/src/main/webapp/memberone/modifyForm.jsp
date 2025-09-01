<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="domain.*"%>
<jsp:useBean id="dao" class="dao.MemberDAO" />
<%
String loginID = (String) session.getAttribute("loginID");
MemberVO vo = dao.getMember(loginID);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<form action="modifyProc.jsp" method="post" name="regForm">
		<table border="1">

			<tr>
				<td colspan="2" align="center">회원 수정 정보 입력</td>
			</tr>

			<tr>
				<!-- 아이디 -->
				<td align="right">아이디:</td>
				<td><%=vo.getMemberId()%> <input type="hidden" name="memberId"
					value="<%=vo.getMemberId()%>"></td>
			</tr>

			<tr>
				<!-- 비밀번호 -->
				<td align="right">비밀번호:</td>
				<td><input type="password" name="password">&nbsp;</td>
			</tr>

			<tr>
				<!-- 비밀번호 확인 -->
				<td align="right">비밀번호 확인:</td>
				<td><input type="password" name="repass">&nbsp;</td>
			</tr>

			<tr>
				<!-- 이름 -->
				<td align="right">이름:</td>
				<td><input type="text" name="memberName"
					value="<%=vo.getMemberName()%>"></td>
			</tr>

			<tr>
				<!-- 이메일 -->
				<td align="right">이메일:</td>
				<td><input type="text" name="email" value="<%=vo.getEmail()%>">&nbsp;
				</td>
			</tr>



			<tr>
				<!-- 버튼 -->
				<td colspan="2" align="center"><input type="button"
					value="수정 확인" onclick="updateCheck()">&nbsp;&nbsp; <input
					type="button" value="취소"
					onclick="javascript:window.location='login.jsp'"></td>
			</tr>

		</table>
	</form>
</body>
</html>
