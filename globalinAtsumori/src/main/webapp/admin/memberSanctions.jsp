<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, dao.MemberDAO, domain.MemberVO"%>

<%
request.setAttribute("bannerMessage", "会員製材管理");
MemberDAO dao = new MemberDAO();

int pageSize = 10; // 한 페이지당 10줄

// 현재 페이지
int currentPage = 1;
String pageParam = request.getParameter("page");
if (pageParam != null) {
	try {
		currentPage = Integer.parseInt(pageParam);
	} catch (NumberFormatException e) {
	}
}

// 검색값 가져오기
String searchType = request.getParameter("searchType");
String keyword = request.getParameter("keyword");
List<MemberVO> list;
int totalCount = 0;

// 검색 조건에 따라 DAO 호출
if (searchType != null && keyword != null && !keyword.isEmpty()) {
	if ("name".equals(searchType)) {
		list = dao.getMembersByName(keyword);
	} else if ("id".equals(searchType)) {
		list = dao.getMembersById(keyword);
	} else if ("permission".equals(searchType)) {
		list = dao.getMembersByPermission(keyword);
	} else {
		list = dao.getMembersByPage(currentPage, pageSize); // 기본 페이징
	}
	totalCount = list.size(); // 검색 결과 기준으로 전체 count
} else {
	list = dao.getMembersByPage(currentPage, pageSize); // 기본 페이징
	totalCount = dao.getTotalCount();
}

// 페이지 계산
int totalPage = (int) Math.ceil(totalCount / (double) pageSize);

// EL에서 사용
request.setAttribute("list", list);
request.setAttribute("searchType", searchType != null ? searchType : "");
request.setAttribute("keyword", keyword != null ? keyword : "");
request.setAttribute("currentPage", currentPage);
request.setAttribute("totalPage", totalPage);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="wrapper">
		<jsp:include page="/includes/navbar.jsp" />
		<jsp:include page="/includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

		<!-- 메뉴 -->
		<form method="get">

			<br> <br>
			<jsp:include page="../includes/adminbanner.jsp" />

			<br> <br>
		</form>

		<!-- 헤더 테이블 -->
		<table class="listhead" style="table-layout: fixed; width: 80%;">
			<thead>
				<tr>
					<th style="width: 20%;">会員番号</th>
					<th style="width: 30%;">ID</th>
					<th style="width: 30%;">名前</th>
					<th style="width: 20%;">製材</th>
				</tr>
			</thead>
		</table>

		<!-- 데이터 테이블 -->
		<table class="listbg" style="table-layout: fixed; width: 80%;">
			<tbody>
				<c:forEach var="m" items="${list}">
					<tr>
						<td style="width: 20%;">${m.memberNo}</td>
						<td style="width: 30%;">${m.memberId}</td>
						<td style="width: 30%;">${m.memberName}</td>
						<td style="width: 20%;">
							<form method="post"
								action="${pageContext.request.contextPath}/admin/memberSanctionsProc.jsp">

								<input type="hidden" name="memberNo" value="${m.memberNo}">
								<select name="sanction_status">
									<option value="無し" ${m.sanctionStatus=='無し'?'selected':''}>無し</option>
									<option value="停止" ${m.sanctionStatus=='停止'?'selected':''}>停止</option>
									<option value="脱退" ${m.sanctionStatus=='脱退'?'selected':''}>脱退</option>
								</select>
								<button type="submit">変更</button>
							</form>
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 페이징 링크 -->
		<div class="pagination admin" style="text-align: center; margin-top: 20px;">
			<c:if test="${currentPage > 1}">
				<a href="?page=${currentPage-1}">前</a>
			</c:if>

			<c:forEach var="i" begin="1" end="${totalPage}">
				<c:choose>
					<c:when test="${i == currentPage}">
						<span>${i}</span>
					</c:when>
					<c:otherwise>
						<a href="?page=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${currentPage < totalPage}">
				<a href="?page=${currentPage+1}">次</a>
			</c:if>
		</div>

		<!-- 검색창 -->
		<div class="search-box">
			<form method="get">
				<select name="searchType">
					<option value="name" ${searchType=='name'?'selected':''}>名前</option>
					<option value="id" ${searchType=='id'?'selected':''}>ID</option>
					<option value="permission"
						${searchType=='permission'?'selected':''}>権限</option>
				</select> <input type="text" name="keyword" value="${keyword}"
					class="adm-input" />
				<button type="submit" class="reg-btn">検索</button>
			</form>
		</div>

	</div>
</body>
</html>
