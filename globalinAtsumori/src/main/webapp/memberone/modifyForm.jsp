<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO"%>
<%@ page import="domain.MemberVO"%>

<%
// 로그인 체크
String loginID = (String) session.getAttribute("loginID");
if (loginID == null) {
	out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
	return;
}

// DAO에서 회원 정보 조회
MemberDAO dao = new MemberDAO();
MemberVO vo = dao.getMember(loginID);

if (vo == null) {
	out.println("<script>alert('회원 정보를 불러올 수 없습니다.'); location.href='login.jsp';</script>");
	return;
}

request.setAttribute("bannerMessage", "회원 정보 수정");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리 - 회원 정보 수정</title>
<link rel="stylesheet" href="/css/style.css">
<script>
	function updateCheck() {
		var form = document.regForm;
		if (form.password.value != form.repass.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.password.focus();
			return false;
		}
		form.submit();
	}
</script>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/includes/navbar.jsp" />
		<jsp:include page="/includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

		<form action="modifyProc.jsp" method="post" name="regForm">

			<br> <br> <br>

			<table class="reg-table">
				<tr>
					<td colspan="2" align="center">회원 정보 수정</td>
				</tr>

				<tr>
					<td class="label">이름</td>
					<td><input type="text" name="memberName"
						value="<%=vo.getMemberName()%>" class="reg-input"></td>
				</tr>
				<tr>
					<td class="label">아이디</td>
					<td><%=vo.getMemberId()%> <input type="hidden" name="memberId"
						value="<%=vo.getMemberId()%>"></td>
				</tr>

				<tr>
					<td class="label">비밀번호</td>
					<td><input type="password" name="password" class="reg-input">&nbsp;</td>
				</tr>

				<tr>
					<td class="label">비밀번호 확인</td>
					<td><input type="password" name="repass" class="reg-input">&nbsp;</td>
				</tr>


				<tr>
					<td class="label">이메일</td>
					<td><input type="text" name="email" value="<%=vo.getEmail()%>"
						class="reg-input"></td>
				</tr>

				<tr>
					<td class="label">국가</td>
					<td><select name="country" class="reg-input">
							<option value="대한민국"
								<%="대한민국".equals(vo.getCountry()) ? "selected" : ""%>>대한민국</option>
							<option value="日本"
								<%="日本".equals(vo.getCountry()) ? "selected" : ""%>>日本</option>
					</select></td>
				</tr>


				<tr>
					<td colspan="2" align="center"><input type="button"
						value="수정 확인" onclick="updateCheck()" class="reg-btn">
						&nbsp;&nbsp; <input type="button" value="취소"
						onclick="javascript:history.back()" class="reg-btn"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>