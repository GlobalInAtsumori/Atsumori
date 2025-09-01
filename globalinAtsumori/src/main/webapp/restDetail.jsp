<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
request.setAttribute("bannerMessage", "アツモリにようこそ！");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 상세</title>
<style>
.container {
	width: 800px;
	margin: 0 auto;
}

.restaurant-info {
    margin-bottom: 20px;
    font-weight: bold;
    font-size: 20px;
    padding: 0 100px;
}

.review {
	display: flex;
	align-items: flex-start;
	width: 600px;
	background: #eaeaea;
	padding: 10px 20px;
	margin: 0 auto 15px;
	border-radius: 8px;
}

.review img {
	width: 150px;
	height: 150px;
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<div class="wrapper">

		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />

		<div class="restaurant-info">
			<br>
			<p>가게명 : ${restDetailDto.restName}</p>
			<p>가게주소 : ${restDetailDto.address}</p>
			<br>
			<p>리뷰 (${restDetailDto.totalReviews})</p>
		</div>

		<c:forEach var="review" items="${restDetailDto.reviewList}">
			<div class="review">
				<c:if test="${not empty review.reviewImgUrl}">
					<img src="${review.reviewImgUrl}" alt="리뷰 이미지">
				</c:if>
				<div class="review-content">
					<div class="review-header">
						<span>${review.memberName} ( ${review.country} ) </span> <span><fmt:formatDate
								value="${review.createDate}" pattern="yyyy-MM-dd" /></span>
					</div>
					<div class="review-title">${review.reviewTitle}</div>
					<div class="review-text">${review.reviewContent}</div>
				</div>
			</div>
		</c:forEach>

		<div style="text-align: center; margin-top: 20px;">
			<c:forEach begin="1" end="${restDetailDto.totalPages}" var="i">
				<c:choose>
					<c:when test="${i == restDetailDto.currentPage}">
						<strong>[${i}]</strong>
					</c:when>
					<c:otherwise>
						<a href="?page=${i}&size=5">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
</body>
</html>