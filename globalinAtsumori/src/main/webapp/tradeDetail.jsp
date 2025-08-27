<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("bannerMessage", "🛍️中古品売買🛍️"); %>
<%-- 테스트를 위해 임시로 로그인 정보 설정 --%>
<%-- 본인 아님 --%>
<% session.setAttribute("loginMemberNo", 3); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${post.tradeTitle}</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/tradeDetail.css">
</head>
<body>
	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
		
		<div class="trd-container">
			
			<!-- 상세 내용 출력 -->
			<div class="trd-content">
				<!-- 사진 & 등록일자, 제목, 가격, 거래희망 버튼 -->
				<div class="trdTop">
					<div class="imgBox"><img alt="image" src="${post.thumbnailUrl}"></div>
					<ul>
						<li class="date">${post.dateFormat}</li>
						<li class="title">${post.tradeTitle}</li>
						<li class="memberName">${post.memberName}</li>
						<li class="costTitle">値段</li>
						<li class="cost">${post.cost}</li>
						<li>
							<form action="updateStatus" method="post">
								<input type="hidden" name="tradePostNo" value="${post.tradePostNo}" />
								<input type="hidden" name="status" value="TRADING" />
								
								<c:choose>
									<c:when test="${post.status eq 'AVAILABLE'}">
										<c:choose>
											<%-- 본인 글일 경우 --%>
											<c:when test="${post.memberNo eq sessionScope.loginMemberNo}">
												<button type="button" class="tradeBtn ${post.tradeBtnClass}" 
												onclick="alert('自分の掲示物は取引が不可能です。')">
													${post.tradeBtnLabel}
												</button>
											</c:when>
											<%-- 본인 글이 아닐 경우 --%>
											<c:otherwise>
												<button type="submit" class="tradeBtn ${post.tradeBtnClass}">
													${post.tradeBtnLabel}
												</button>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:when test="${post.status eq 'TRADING'}">
										<button type="submit" class="tradeBtn ${post.tradeBtnClass}" disabled>${post.tradeBtnLabel}</button>
									</c:when>
									<c:when test="${post.status eq 'DONE'}">
										<button type="submit" class="tradeBtn ${post.tradeBtnClass}" disabled>${post.tradeBtnLabel}</button>
									</c:when>
								</c:choose>
							</form>
						</li>
					</ul>
				</div>
				
				<!-- 상세설명 -->
				<div class="trdBottom">
					<p class="detailTitle">詳細説明</p>
					<p class="detail">${post.tradeContent}</p>
				</div>
				
			</div>
			
			
			<!-- 버튼 출력 -->
			<button id="trList" onclick="location.href='tradeMain'">リスト</button>
			
		</div>
	</div>
</body>
</html>