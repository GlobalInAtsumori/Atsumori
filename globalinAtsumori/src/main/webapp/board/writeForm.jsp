<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>
<%@ include file="color.jsp" %>		<%-- 색상 변수들이 정의된 JSP 파일을 포함 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="script.js"></script>		<%-- 자바스크립트 파일 연결 --%>
</head>

<!-- 새글과 답변글을 구분하는 코드 추가 -->
<%
int boardno = 0;
try {
    // 기존 글에 대한 답변이라면 (파라미터가 존재할 경우) 값들을 받아옴
			if(request.getParameter("boardno") != null){
				boardno = Integer.parseInt(request.getParameter("boardno"));
			}
%>

<body bgcolor="<%=bodyback_c%>">				<%-- 배경색은 color.jsp에서 설정한 변수 사용 --%>

<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

<div align="center"><br><b>글쓰기</b></div><br>
<form action="writeProc.jsp" method="post" name="writeForm"
onsubmit="return writeSave()">
    <%-- 글 작성 완료 시 writeProc.jsp로 POST 전송 / 자바스크립트 유효성 검사 수행 --%>

<table width="470" border="1" cellpadding="0" cellspacing="0"
align="center" bgcolor="<%=bodyback_c%>">

    <%-- 상단: 글목록으로 이동하는 링크 --%>
<tr>
		<td align="right" colspan="2" bgcolor="<%=value_c%>">
				<a href="list.jsp">글목록</a>
		</td>
</tr>

    <%-- 이름 입력칸 --%>
<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">이름</td>
	<td width="330">
			<input type="text" size="12" maxlength="12" name="writer">
	</td>
</tr>

    <%-- 이메일 입력칸 --%>
<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">이메일</td>
	<td width="330">
			<input type="text" size="30" maxlength="30" name="email">
	</td>
</tr>

    <%-- 제목 입력칸: 답변글인 경우 '[답변]' 텍스트 추가 --%>
<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">제목</td>
	<td width="330">
			<% if(request.getParameter("num") == null) { %>
			<input type="text" size="50" maxlength="50" name="subject">
			<% }else { %>
			<input type="text" size="50" maxlength="50" name="subject" value="[답변]">
			<% } %>
	</td>
</tr>

    <%-- 내용 입력칸 --%>
<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">내용</td>
	<td width="330">
		<textarea rows="13" cols="50" name="content"></textarea>
	</td>
</tr>

    <%-- 비밀번호 입력칸: 수정/삭제 시 사용됨 --%>
<tr>
	<td width="70" bgcolor="<%=value_c%>" align="center">비밀번호</td>
	<td width="330">
			<input type="password" size="10" maxlength="10" name="pass">
	</td>
</tr>

    <%-- 하단 버튼: 글쓰기 / 다시작성 / 목록으로 이동 --%>
<tr>
		<td align="center" colspan="2" bgcolor="<%=value_c%>">
				<input type="submit" value="글쓰기">
				<input type="reset" value="다시작성">
				<input type="button" value="글목록"
				onclick="window.location='list.jsp'">
		</td>
</tr>


</table>

</form>
<%}catch(Exception e){e.printStackTrace();} %>
</div>
</body>
</html>