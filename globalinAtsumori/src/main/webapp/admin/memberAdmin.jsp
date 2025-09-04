<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
/* 세션은 여기에 입력   */

request.setAttribute("bannerMessage", "회원 관리");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet" href="/css/style.css">

</head>
<body>
	<div class="wrapper">
		<jsp:include page="/includes/navbar.jsp" />
		<jsp:include page="/includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		<!-- 여기까지가 상단부   이 밑으로는 페이지 내용 등등 -->

		<form method="get"
			action="${pageContext.request.contextPath}/admin/memberList">
			<br>

			<table class="adminbanner">
				<tr>
					<td class="label">회원관리</td>
					<td><a href="memberAdmin.jsp">권한</a></td>
					<td><a href="memberAdmin.jsp">제재</a></td>
				</tr>
			</table>
			<br>
		</form>
		
		<table class="listhead">
    <thead>
        <tr>
            <th>회원번호</th>
            <th>아이디</th>
            <th>이름</th>
            <th>권한</th>
            <th>이메일</th>
            <th>국가</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="m" items="${list}">
        <tr>
            <td>${m.memberNo}</td>
            <td>${m.memberId}</td>
            <td>${m.memberName}</td>
            <td>
                <form method="post" action="memberAdminProc.jsp">
                    <input type="hidden" name="memberNo" value="${m.memberNo}">
                    <select name="permission">
                        <option value="user" ${m.permission=='user'?'selected':''}>user</option>
                        <option value="admin" ${m.permission=='admin'?'selected':''}>admin</option>
                        <option value="moderator" ${m.permission=='moderator'?'selected':''}>moderator</option>
                    </select>
                    <button type="submit">변경</button>
                </form>
            </td>
            <td>${m.email}</td>
            <td>${m.country}</td>
        </tr>
    </c:forEach>
</tbody>
</table>


 <script>
        function changePermission(memberNo, permission) {
            // Ajax 또는 form submit으로 권한 변경 호출
            alert("회원번호 " + memberNo + " 권한을 " + permission + "로 변경합니다.");
            // 실제 권한 변경 로직은 서버쪽 updatePermission 호출
        }
        </script>
		<!-- ========================================================================= -->

		<!-- 검색창 영역 -->
		<div class="search-box">
			<select name="searchType">
				<option value="name" ${searchType=='name'?'selected':''}>이름</option>
				<option value="id" ${searchType=='id'?'selected':''}>아이디</option>
				<option value="permission" ${searchType=='permission'?'selected':''}>권한</option>
			</select> <input type="text" name="keyword" value="${keyword}"
				class="adm-input" />
			<button type="submit" class="reg-btn">검색</button>
		</div>

		<!-- ============================================검색창!~~!~!~================================== -->

	</div>


</body>
</html>
