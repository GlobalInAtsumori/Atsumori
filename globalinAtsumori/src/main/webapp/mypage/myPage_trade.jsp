<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
request.setAttribute("bannerMessage", "MyPage : 中古品売買");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>아쯔모리</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypageTrade.css">
	
	
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
			/* 	gap: 20px; */
			width: 530px; /* 가로 크기 고정 */
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
			padding: 15px;
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
				<div class="myPageTitle tab-buttons">
					<button type="button" id="myPost" class="active">自分の投稿</button>
					<button type="button" id="myTrade">取引希望した投稿</button>
				</div>
				
				<%-- DB에 저장된 해당 데이터를 전부 불러오는 코드 시작 --%>
				<div class="myPageContent">
					<div class="tab-contents">
						
						<!-- 내가 쓴 글 -->
						<div id="myPostContents">
							<div class="top first">
								<ul class="basic">
									<li class="no">NO</li>
									<li class="title">タイトル</li>
									<li class="date">投稿日</li>
									<li class="status">進行状況</li>
									<li class="check">承諾</li>
								</ul>
								<div class="top second">
									<c:if test="${empty myPostList}">
										<p class="empty">まだ投稿がありません。</p>
									</c:if>
									<c:forEach var="post" items="${myPostList}">
										<ul class="posts">
											<li class="no">${post.rn}</li>
											<li class="title">
												<a href="/tradeDetail?tradePostNo=${post.tradePostNo}">
												${post.tradeTitle}
												</a>
											</li>
											<li class="date">${post.dateFormat}</li>
											<li class="status ${post.tradeBtnClass}"><div>${post.statusLabel}</div></li>
											<li class="check">
												<c:if test="${post.status eq 'TRADING'}">
													<form action="/mypage/updateTradeStatus" method="post" onsubmit="return confirmSubmit();">
														<input type="hidden" name="tradePostNo" value="${post.tradePostNo}">
														<button type="submit" class="check">承諾!</button>
													</form>
												</c:if>
											</li>
										</ul>
									</c:forEach>
								</div>
							</div>
							<!-- 페이징 -->
							<div class="pagination">
								<c:if test="${startPage > 1}">
									<a href="?page=${startPage-1}" class="prev">‹ 前へ</a>
								</c:if>
								<c:forEach begin="${startPage}" end="${endPage}" var="p">
									<c:choose>
										<c:when test="${p == currentPage}">
											<span class="num current">${p}</span>
										</c:when>
										<c:otherwise>
											<a href="?page=${p}" class="num">${p}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${endPage < totalPages}">
									<a href="?page=${endPage+1}" class="next">次へ ›</a>
								</c:if>
							</div>
						</div>
						
						
						<!-- 거래희망한 글 -->
						<div id="myTradeContents" style="display: none;">
							<ul class="basic2">
								<li class="no">NO</li>
								<li class="title">タイトル</li>
								<li class="date">投稿日</li>
								<li class="status">進行状況</li>
							</ul>
							<c:if test="${empty requestedTrades}">
								<p class="empty">まだ取引希望した投稿がありません。</p>
							</c:if>
							<c:forEach var="post" items="${requestedTrades}">
								<ul class="lists">
									<li class="no">${post.rn}</li>
									<li class="title">
										<a href="/tradeDetail?tradePostNo=${post.tradePostNo}">
										${post.tradeTitle}
										</a>
									</li>
									<li class="date">${post.dateFormat}</li>
									<li class="status ${post.tradeBtnClass}"><div>${post.statusLabel}</div></li>
								</ul>
							</c:forEach>
						</div>
					</div>
				</div>
				<%-- DB에 저장된 해당 데이터를 전부 불러오는 코드 끝 --%>
			</div>		<%-- myPageWrapper2의 끝 --%>
			
		</div>		<%-- myPageWrapper1의 끝 --%>
		
		
		
	</div>
</body>

	<script type="text/javascript">
		const myPost = document.getElementById('myPost');
		const myTrade = document.getElementById('myTrade');
		const myPostContents = document.getElementById('myPostContents');
		const myTradeContents = document.getElementById('myTradeContents');
		
		const buttons = document.querySelectorAll('.tab-buttons button');
		
		buttons.forEach(button => {
			button.addEventListener('click', () => {
				//모든 버튼의 active를 제거함
				buttons.forEach(b => b.classList.remove('active'));
				//클릭한 버튼만 active 추가
				button.classList.add('active');
			});
		});
		
		// 게시글 토글
		myPost.addEventListener('click', () => {
			myPostContents.style.display = 'block';
			myTradeContents.style.display = 'none';
		});
		myTrade.addEventListener('click', () => {
			myPostContents.style.display = 'none';
			myTradeContents.style.display = 'block';
		});
		
		//승낙 전 확인 알림
		function confirmSubmit() {
			return confirm("本当に承諾しますか？");
		}
	</script>
</html>