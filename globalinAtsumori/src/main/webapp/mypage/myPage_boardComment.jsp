<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
request.setAttribute("bannerMessage", "MyPage");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아쯔모리</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	
	
	<style>
		.myPageWrapper1 {
			display: flex;
			gap: 20px;
			margin-top: 70px;
			padding: 20px;
		}
		
		.myPageMenu {
			width: 200px;
			height: 500px;
			border: 2px solid black;
			padding: 20px 0;
			text-align: center;
			background-color: #fff; /* 배경색 추가 */
		}
		
		.myPageWrapper2 {
			display: flex;
			flex-direction: column; /* 자식 요소들을 세로로 정렬 */
			flex-grow: 1;
			gap: 20px;
		}
		
		.myPageTitle {
			border: 2px solid black;
			height: 50px;
			display: flex;
			justify-content: center;
			align-items: center;
			background-color: #fff;
		}
		
		.myPageContent {
			margin-top: 10px;
			border: 2px solid black;
			padding: 20px;
			background-color: #fff;
			/* min-height: 200px; */
			/* flex-grow: 1; /* 남은 공간을 채우도록 함 */
		}
	</style>
	
	
</head>
<body>
	<div class="wrapper">
	
		<jsp:include page="/includes/navbar.jsp" />
		<jsp:include page="/includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		
		
		<div class="myPageWrapper1">		<%-- myPageWrapper1의 시작 --%>
		
			<div class="myPageMenu">
			<!-- 왼쪽 마이페이지 카테고리 테이블 -->
					<b style="font-size:20px;">《마이 페이지》</b><br><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">회원 정보 확인</a><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage_memberUpdate"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">회원 정보 수정</a><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage_board"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">내가 쓴 게시글 보기</a><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage_boardComment"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">내가 쓴 댓글 보기</a><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage_restaurantReview"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">내가 쓴 맛집리뷰글 보기</a><br><br><br>
						<a href=
						"${pageContext.request.contextPath}/mypage/myPage_trade"
						style="font-weight:bold; color:black; text-decoration:none;"
						onmouseover="this.style.textDecoration='underline';"
						onmouseout="this.style.textDecoration='none';">내가 쓴 중고거래글 보기</a><br><br><br>
			</div>
		
		
			<div class="myPageWrapper2">		<%-- myPageWrapper2의 시작 --%>
				<div class="myPageTitle">
					<b style="font-size:20px;">내가 쓴 댓글 보기</b>
				</div>
				<div class="myPageContent">
				
				
				
					<%-- DB에 저장된 해당 데이터를 전부 불러오는 코드 시작 --%>
					<%-- "myCommentList" 변수가 비어있지 않으면 테이블을 표시함 --%>
					<c:choose>
						<c:when test="${not empty myCommentList}">
							<table class="myCommentTable">
								<thead>
									<tr>
										<th>댓글번호</th>
										<th>내용</th>
										<th>작성일자</th>
									</tr>
								</thead>
								<tbody>
									<%-- "myCommentList"의 각 항목을 반복하며 테이블 행을 생성함 --%>
									<c:forEach var="comment" items="${myCommentList}">
										<tr>
											<td>${comment.commentNo}</td>
											<td>
												<a href="${pageContext.request.contextPath}/board/content?boardno=${comment.boardNo}&pageNum=1">
													${comment.content}
												</a>
											</td>
											<td><fmt:formatDate value="${comment.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:when>
						<c:otherwise>
							<p>작성된 댓글이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				<%-- DB에 저장된 해당 데이터를 전부 불러오는 코드 끝 --%>
					
					
					
				</div>
			</div>		<%-- myPageWrapper2의 끝 --%>
			
		</div>		<%-- myPageWrapper1의 끝 --%>
		
		
		
	</div>
</body>
</html>