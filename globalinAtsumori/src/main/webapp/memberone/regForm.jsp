<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
	request.setAttribute("bannerMessage", "会員登録");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="script.js"></script>
</head>
<body>
	<div class="wrapper">
		<jsp:include page="../includes/navbar.jsp" />
		<jsp:include page="../includes/banner.jsp" />
		<form action="regProc.jsp" method="post" name="regForm">
			<br>
			<br>
			<br>
			<br>
			
			<table class="reg-table">


				
			
				<tr>
					<td class="label">名前</td>
					<td><input type="text" name="memberName" class="reg-input"></td>
				</tr>
				<tr>
					<td class="label">ID</td>
					<td><input type="text" name="memberId" class="reg-input">
						<input type="button" value="重複確認" class="reg-checkbtn"
						onclick="idCheck(this.form.memberId.value)"></td>
				</tr>
				<tr>
					<td class="label">PW</td>
					<td><input type="password" name="password" class="reg-input"></td>
				</tr>
				<tr>
					<td class="label">PW<br>確認</td>
					<td><input type="password" name="repass" class="reg-input"></td>
				</tr>
				<!-- 국가 먼저 -->
				<tr>
					<td class="label">国</td>
					<td><select name="country" class="reg-input">
							<option value="大韓民国">大韓民国</option>
							<option value="日本">日本</option>
					</select></td>
				</tr>
				<!-- 이메일 나중 -->
				<tr>
					<td class="label">Email</td>
					<td><input type="text" name="email" class="reg-input">
						@ <select name="emailDomain" id="emailDomain"
						onchange="toggleCustomEmail(this)" class="reg-input">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="直接入力">直接入力</option>
					</select> <input type="text" name="emailDomainCustom" id="emailDomainCustom"
						style="display: none;" class="reg-input"
						placeholder="예: kakao.com"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="reset"
						value="再入力" class="reg-btn"> <input type="button"
						value="入力完了" class="reg-btn" onclick="inputCheck()"></td>
				</tr>
			</table>
			<input type="hidden" name="permission" value="user">
		</form>
	</div>
</body>
</html>
