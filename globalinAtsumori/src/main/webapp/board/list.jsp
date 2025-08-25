<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>


<%@ page import="java.util.List"%>
<%@ page import="dto.BoardDTO"%>
<%@ include file="color.jsp"%>

<%
	// Controller가 Model에 담아준 데이터를 가져와서 사용합니다.
	int count = (Integer) request.getAttribute("count");
	int number = (Integer) request.getAttribute("number");
	int pageSize = (Integer) request.getAttribute("pageSize");
	int pageNum = (Integer) request.getAttribute("pageNum");
	String searchWhat = (String) request.getAttribute("searchWhat");
	String searchText = (String) request.getAttribute("searchText");
	
	List<BoardDTO> articleList = (List<BoardDTO>) request.getAttribute("articleList");
	
%>
			
		

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body bgcolor="<%=bodyback_c%>">
<div class="wrapper">
	<jsp:include page="/includes/navbar.jsp" />
	<jsp:include page="/includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

	<div align="center">
		<br><b>글목록(전체 글: <%=count%>)
		</b>
		<p>
		
		
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번호</td>
				<td align="center" width="250">제목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
			</tr>
			<%
			if (articleList != null && !articleList.isEmpty()) {
				for (int i = 0; i < articleList.size(); i++) {
					BoardDTO article = articleList.get(i);
			%>
			
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<a href="content.do?boardno=<%=article.getBoardno()%>&pageNum=<%=pageNum%>">
						<%=article.getTitle()%>
					</a>
				</td>
				<td align="center" width="100">
					<%=article.getMemberno()%>
				</td>
				<td align="center" width="150">
					<%=article.getCreatedate()%>
				</td>
			</tr>
			<%
				}
			} else {
			%>
			<tr>
				<td colspan="4" align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>
			<%
			}
			%>
		</table>
		

		<%
		if (count > 0) {
			int pageBlock = 5;
			int imsi = count % pageSize == 0 ? 0 : 1;
			int pageCount = count / pageSize + imsi;
			int startPage = (int) ((pageNum - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageBlock) {
				%>
				<a href="list.do?pageNum=<%=startPage - pageBlock%>">[이전]</a>
				<%
			}
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.do?pageNum=<%=i%>">[<%=i%>]</a>
			<%
			}
			if (endPage < pageCount) {
			%>
			<a href="list.do?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
			}
		}
		%>
		
		<div style="text-align: right; width: 700px; margin: 10px auto;">
		
		<%
			String loginID = (String) session.getAttribute("loginID");
			if (loginID == null){
		%>
			<form action="<%= request.getContextPath() %>/member/login.jsp" method="post"
				onsubmit="return alert('로그인이 되지 않았습니다. 로그인 해 주세요.');">
				<input type="submit" value="글쓰기">
			</form>
		<%
			} else {
		%>
			<form action="writeForm.do"> <input type="submit" value="글쓰기">
			</form>
		<%
			}
		%>
			
		</div>
		
		<form action="list.do">
			<select name="searchWhat">
				<option value="writer" <%="writer".equals(searchWhat) ? "selected" : ""%>>작성자</option>
				<option value="subject" <%="subject".equals(searchWhat) ? "selected" : ""%>>제목</option>
				<option value="content" <%="content".equals(searchWhat) ? "selected" : ""%>>내용</option>
			</select> <input type="text" name="searchText" value="<%= searchText != null ? searchText : "" %>">
			<input type="submit" value="검색">
		</form>
	</div>
	
</div>
</body>
</html>
