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
		    align-items: stretch; /* 자식 요소 높이를 동일하게 맞춤 */
		}
		
		.myPageMenu {
		    width: 200px;
		    /* height: 500px;  <- 제거 */
		    border: 2px solid black;
		    padding: 20px 0;
		    text-align: center;
		    background-color: #fff;
		}
		
		.myPageWrapper2 {
			display: flex;
			flex-direction: column; /* 자식 요소들을 세로로 정렬 */
			flex-grow: 1;
			gap: 20px;
			width: 530px;	/* 가로 크기 고정 */
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
		
		.review {
			display: flex;
			align-items: flex-start;
			width: 100%; /* 부모(myPageContent)에 맞춤 */
   			max-width: none;
			background: #eaeaea;
			padding: 10px 20px;
			margin: 0 0 15px 0;
			box-sizing: border-box;
			border-radius: 8px;
		}
		
		.review img {
			width: 120px;
			height: 120px;
			object-fit: cover;
			margin-right: 15px;
			border-radius: 8px;
		}
		
		.review-content {
			flex: 1;
		}
		
		.review-header {
			display: flex;
			justify-content: space-between;
			color: gray;
			margin-bottom: 5px;
		}
		
		.review-title {
			font-weight: bold;
			margin-bottom: 5px;
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
					<b style="font-size:20px;">내가 쓴 맛집리뷰글 보기</b>
				</div>
				<div class="myPageContent">
				
					<%-- 여기에 내가 쓴 맛집 리뷰글 --%>	
					<c:forEach var="review" items="${myReviewDTO.reviewList}">
						<div class="review"
						onclick="location.href='${pageContext.request.contextPath}/restaurant/${review.restNo}'" 
         				style="cursor:pointer;">
							<c:if test="${not empty review.reviewImgUrl}">
								<img src="${review.reviewImgUrl}" alt="리뷰 이미지">
							</c:if>
							<div class="review-content">
								<div class="review-header">
									<span>${review.memberName} ( ${review.country} ) </span> 
									<span><fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd" /></span>
								</div>
								<div class="review-title">${review.reviewTitle}</div>
								<div class="review-text">${review.reviewContent}</div>
							</div>
						</div>
					</c:forEach>
			
					<div style="text-align: center; margin-top: 20px;">
						<c:forEach begin="1" end="${myReviewDTO.totalPages}" var="i">
							<c:choose>
								<c:when test="${i == myReviewDTO.currentPage}">
									<strong>[${i}]</strong>
								</c:when>
								<c:otherwise>
									<a href="?page=${i}&size=5">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				
				</div>
			</div>		<%-- myPageWrapper2의 끝 --%>
			
		</div>		<%-- myPageWrapper1의 끝 --%>
	</div>
</body>
</html>