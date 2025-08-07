<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
</head>
<body bgcolor="#fef7b5">
<form action="regProc.jsp" method="post" name="regForm">
<table border="1">

<tr>
	<td colspan="2" align="center">회원가입 정보 입력</td>
</tr>


<tr> <!-- 이름 -->
	<td align="right">이름: </td>
	<td><input type="text" name="memberName">&nbsp;</td>
</tr>

<tr> <!-- 아이디 -->
	<td align="right">아이디: </td>
	<td>
		<input type="text" name="memberId">&nbsp;
		<input type="button" value="중복확인" onclick="idCheck(this.form.memberId.value)">
	</td>
</tr>

<tr> <!-- 비밀번호 -->
	<td align="right">비밀번호: </td>
	<td><input type="password" name="password">&nbsp;</td>
</tr>

<tr> <!-- 비밀번호 확인 -->
	<td align="right">비밀번호 확인: </td>
	<td><input type="password" name="repass">&nbsp;</td>
</tr>

<tr> <!-- 국가 -->
	<td align="right">국가: </td>
	<td>
		<select name="country">
			<option value="대한민국">대한민국</option>
			<option value="日本">日本</option>
		</select>
	</td>
</tr>

<tr> <!-- 이메일 -->
  <td align="right">이메일: </td>
  <td>
    <input type="text" name="emailId"> @

    <select name="emailDomain" id="emailDomain" onchange="toggleCustomEmail(this)">
      <option value="naver.com">naver.com</option>
      <option value="gmail.com">gmail.com</option>
      <option value="daum.net">daum.net</option>
      <option value="nate.com">nate.com</option>
      <option value="직접입력">직접입력</option>
    </select>

    <input type="text" name="emailDomainCustom" id="emailDomainCustom" style="display:none;" placeholder="예: kakao.com">
  </td>
</tr>

<script>
  function toggleCustomEmail(selectElement) {
    var customInput = document.getElementById("emailDomainCustom");

    if (selectElement.value === "직접입력") {
      customInput.style.display = "inline-block";
      customInput.name = "emailDomain"; // 폼 전송을 위해 name 변경
    } else {
      customInput.style.display = "none";
      customInput.name = "emailDomainCustom"; // 사용되지 않게 name 변경
    }
  }
</script>

<tr> <!-- 버튼 -->
	<td colspan="2" align="center">
		<input type="button" value="회원가입" onclick="inputCheck()"> &nbsp;&nbsp;
		<input type="reset" value="다시 입력">
	</td>
</tr>

</table>
</form>
</body>
</html>
