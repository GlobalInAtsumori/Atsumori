<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  <%-- 이 부분은 JSP 파일의 설정입니다. JSP는 자바 기반의 웹 페이지이고, 페이지에서 사용할 언어는 Java, 문자 인코딩은 UTF-8로 설정되어 있어야 한글이 깨지지 않습니다. --%>

<%
	String loginID = (String)session.getAttribute("loginID");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">   <%-- 웹 페이지 자체의 문자 인코딩을 UTF-8로 설정합니다. --%>
<title>Login</title>			<%-- 웹 브라우저 탭에 표시될 제목입니다. --%>
<link href="style.css" rel="stylesheet" type="text/css">			<%-- 외부 CSS 파일(style.css)을 불러와서 페이지 디자인에 사용합니다. --%>
</head>
<body>

<% if(loginID != null) { %>
<table width="300" border="1">
		<tr>
			<td colspan="3" align="center"><%=loginID%>님 환영합니다. (ㅎ,,ㅎ)♥♥</td>
		</tr>
		
		<tr>
			<td align="center" width="100">
			<a href="modifyForm.jsp">정보수정</a></td>
			<td align="center" width="100">
			<a href="deleteForm.jsp">회원탈퇴</a></td>
			<td align="center" width="100">
			<a href="logout.jsp">로그아웃</a></td>
		</tr>
		
		<%-- 임시로 만들어둔 메인페이지 버튼. 테스트끝나면 지울거임 시작--%>
		<tr>
			<td align="center" width="100">
			<a href="<%=request.getContextPath()%>/mainPage.jsp">메인페이지</a></td>
		</tr>
		<%-- 임시로 만들어둔 메인페이지 버튼. 테스트끝나면 지울거임 끝--%>
		
</table>

<% } else { %>

<!-- 로그인 폼 시작 -->
<form action="loginProc.jsp" method="post">
<%-- action="#"는 현재 페이지에 데이터를 제출한다는 의미이고, method="post"는 입력한 정보를 숨겨서 전송하는 방식입니다. --%>

<!-- 로그인 정보를 입력받는 표(table) -->
<table width="300" border="1">


		<tr>
			<td colspan="2" align="center">회원 로그인</td>
			<%-- 첫 번째 줄: "회원 로그인"이라는 제목을 표 가운데에 표시하고, 두 칸을 합칩니다. --%>
		</tr>
		
		<tr>
			<td align="right" width="100"> 아이디 </td>
			<td width="200">&nbsp;&nbsp;
			<input type="text" name="id" size="20">
			<%-- 오른쪽 셀: 아이디를 입력하는 텍스트 상자입니다. name="id"는 서버로 보낼 때 사용하는 이름입니다. --%>
			</td>
		</tr>
		
		<tr>
			<td align="right" width="100"> 비밀번호 </td>
			<td width="200">&nbsp;&nbsp;
			<input type="password" name="pass" size="20">
			<%-- 비밀번호 입력란입니다. 입력한 글자가 보이지 않도록 처리됩니다. --%>
			</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="로그인">
				<%-- 로그인 버튼을 눌렀을 때 폼에 입력한 정보를 전송합니다. --%>
				&nbsp;&nbsp;
				<input type="button" value="회원가입"
				onclick="javascript:window.location='regForm.jsp'">
				<%-- 버튼을 클릭하면 'regForm.jsp'라는 회원가입 페이지로 이동합니다. --%>
				
				
				<%-- 이 버튼은 테스트 끝나면 지울예정 --%>
				<input type="button" value="메인페이지"
				onclick="window.location='<%=request.getContextPath()%>/mainPage.jsp'">
				<%-- 이 버튼은 테스트 끝나면 지울예정 --%>
				
				
			</td>
		</tr>
		

</table>
<%-- table은 form 안에 있어야 합니다. 즉, 사용자가 입력한 데이터를 함께 전송하기 위해 table을 form 태그 내부에 두는 것이 맞습니다. --%>
</form>
<%} %>
</body>
</html>