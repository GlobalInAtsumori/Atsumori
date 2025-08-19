<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setAttribute("bannerMessage", "자유 게시판(ღ˘⌣˘ღ)"); %>


<%--    <%@ page import = "com.boardone.BoardDAO"   %>
    <%@ page import = "com.boardone.BoardVO"   %> --%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>


<%@ page import="board.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="color.jsp"%>

<%!// jsp 선언문 내에 날짜 포맷 클래스 인스턴스 변수 선언 및 초기화    
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

<%
String pageNum = request.getParameter("pageNum");
String searchWhat = request.getParameter("searchWhat");
String searchText = request.getParameter("searchText");


if (pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

int count = 0;
int number = 0;
List<BoardVO> articleList = null;
BoardDAO dbPro = BoardDAO.getInstance();

	if (searchWhat != null && searchText != null) {
		count = dbPro.getArticleCount(searchWhat, searchText);
		if (count > 0){
			articleList = dbPro.getArticles(searchWhat, searchText, startRow, endRow);
		}
	}else {
		// 전체글 가져오기
		count = dbPro.getArticleCount();
		// 글이 있을 경우
		if (count > 0) {
		articleList = dbPro.getArticles(startRow, endRow); // 글을 가져다가 리스트에 저장한다.
		}
	}
	number = count - (currentPage - 1) * pageSize; // number는 브라우저에 출력
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
		<p>		<%-- 한칸 띄움 --%>
		
		
		<%-- 임시로 만들어둔 로그인정보 버튼. 테스트끝나면 지울거임 시작--%>
		<tr>
			<td align="center" width="100">
			<a href="<%=request.getContextPath()%>/memberone/login.jsp">로그인정보</a></td>
		</tr>
		<%-- 임시로 만들어둔 로그인정보 버튼. 테스트끝나면 지울거임 끝--%>
		
		
		<%--글목록(전체 글: count) 아래에 표시되는 글쓰기 링크 --%>
		<%--
		<table width="700">
			<tr>
				<td align="right" bgcolor=" <%=value_c%>"><a
					href="writeForm.jsp">글쓰기</a></td>
			</tr>
		</table>
		--%>
		<%
		if (count == 0) {
		%>

		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			<tr>
		</table>
		<%
		} else {
		%>
		<table width="700" align="center" border="1" cellpadding="0"
			cellspacing="0">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번호</td>
				<td align="center" width="250">제목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조회</td>
				<td align="center" width="100">IP</td>
			</tr>
			<tr>
				<%
				if (articleList != null && articleList.size() > 0) {
					for (int i = 0; i < articleList.size(); i++) {
						BoardVO article = articleList.get(i);
				%>
			
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<%
					int wid = 0;
					if (article.getDepth() > 0) {
						wid = 5 * (article.getDepth());
					%> <img src="img/level.gif" width="<%=wid%> height="16"> <img
					src="img/re.gif"> <%
							 } else {
							 %> <img src="img/level.gif" width="<%=wid%> height=16"> <%
							 }
							 %> <a href="content.jsp?num=<%=article.getNum()%>&pageNum=1">
													<%=article.getSubject()%>
											</a> <%
							 if (article.getReadcount() >= 5) {
							 %> <img src="img/hot.gif" border="0" height="16"> <%
							 }
							 %>
				</td>
				<td align="center" width="100"><a
					href="mailto:<%=article.getEmail()%>"> <%=article.getWriter()%>
				</a></td>
				<td align="center" width="150"><%=sdf.format(article.getRegdate())%>
				</td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
				<td align="center" width="100"><%=article.getIp()%></td>
			</tr>
			<%
				}
			}
			%>


		</table>
		<%
		}
		%>

		<!-- 페이징 처리  -->
		<%
		if (count > 0) {
			int pageBlock = 5;
			int imsi = count % pageSize == 0 ? 0 : 1;
			// 나머지가 있으면 1을 추가해서 pageCount에서 받음
			int pageCount = count / pageSize + imsi;

			int startPage = (int) ((currentPage - 1) / pageBlock) * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;

			if (endPage > pageCount)
				endPage = pageCount;

			if (startPage > pageBlock) {
				%>
				<a href="list.jsp?pageNum=<%=startPage - pageBlock%>">[이전]</a>
				<%
			} // end if
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]
			</a>
			<%
			} //end for
			if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + pageBlock%>">[다음]</a>
			<%
			} // end if
		}
		%>
		
		
		
		<%
			String loginID = (String) session.getAttribute("loginID");
		%>
		
		<div style="text-align: right; width: 700px; margin: 10px auto;">
		
		<%
			if (loginID == null){
		%>
			
			<form action="<%= request.getContextPath() %>/memberone/login.jsp" method="post"
				onsubmit="return alert('로그인이 되지 않았습니다. 로그인 해 주세요.');">
				<input type="submit" value="글쓰기">
			</form>
				
		<%
			} else {
		%>
			
			<form action="writeForm.jsp">
				<input type="submit" value="글쓰기">
			</form>
			
		<%
			}
		%>
			
		</div>
		
		
		<%--
		<div style="text-align: right; width: 700px; margin: 10px auto;">
		<form action="writeForm.jsp">
		<input type="submit" value="글쓰기">
		</form>
		</div>
		--%>
		
		<!-- 검색일때, 검색이 아닐때 -->
		<form action="list.jsp">
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