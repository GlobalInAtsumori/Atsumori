<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>웹소켓 실시간 채팅</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles_RTC.css">
</head>
<body>
	<script>
		let isChatActive = false; // 실시간 채팅창 활성화 여부

		function initChat() {
			// 페이지 로드 시 초기 상태 설정
			// div.group & introSection숨기기 test
			// document.querySelector(".group").style.display = "none"; 
			// querySelector는 첫번째 .group 요소만 숨기기 

			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("chatFrameContainer").style.display = "none";
			document.getElementById("chatHeader").style.display = "none";
			document.getElementById("introSection").style.display = "block";
			document.getElementById("toggleBtn").style.display = "block";
			document.getElementById("chatFrame").src = ""; // iframe 초기화
			document.getElementById("chatId").value = ""; // 입력 필드 초기화
			isChatActive = false; // 초기 상태: 닉네임 입력 모드
		}

		function chatWinOpen() {
			var id = document.getElementById("chatId");
			if (!id.value.trim()) {
				alert("대화명을 입력 후 채팅창을 열어주세요.");
				id.focus();
				return;
			}

			var frame = document.getElementById("chatFrame");
			frame.src = "/includes/ChatWindow_20250805.jsp?chatId="
					+ encodeURIComponent(id.value);

			document.getElementById("introSection").style.display = "none"; // introSection 숨기기
			document.getElementById("chatFrameContainer").style.display = "block";
			document.getElementById("chatContainer").style.display = "block";
			document.getElementById("chatHeader").style.display = "flex"; // 상단 바 표시
			document.getElementById("toggleBtn").style.display = "none"; // 토글 버튼 숨기기
/* 	        document.getElementById("chatContainer2").style.height = "540px";
	        document.getElementById("chatContainer2").style.width = "230px"; */
			id.value = "";
			isChatActive = true; // 실시간 채팅 모드로 전환

			frame.onload = function() {
				var chatWindow = frame.contentDocument
						.getElementById("chatWindow");
				if (chatWindow) {
					chatWindow.scrollTop = chatWindow.scrollHeight; // 항상 맨 아래로
				}
			};

		}

		function checkEnter(event) {
			if (event.keyCode === 13) { // Enter 키의 키 코드는 13
				chatWinOpen();
			}
		}

		function toggleChat() {
			const container = document.getElementById("chatContainer");
			const toggleBtn = document.getElementById("toggleBtn");
			const chatHeader = document.getElementById("chatHeader");
			const introSection = document.getElementById("introSection");
			const chatFrameContainer = document
					.getElementById("chatFrameContainer");

			if (container.style.display === "none") {
				container.style.display = "block";
				toggleBtn.style.display = "none"; //토글 버튼 숨기기
				if (isChatActive) {
					chatHeader.style.display = "flex";
					chatFrameContainer.style.display = "block";
					introSection.style.display = "none";
				} else {
					chatHeader.style.display = "none"; // 토글로 열 때 상단 바 숨기기
					chatFrameContainer.style.display = "none";
					introSection.style.display = "block"; // introSection 표시
				}
			} else {
				container.style.display = "none";
				toggleBtn.style.display = "block"; // 토글 버튼 표시
			}
		}

		function minimizeChat() {
			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("toggleBtn").style.display = "block"; // 토글 버튼 표시
		}

		// 채팅 종료 시 div.group 복구 (ChatWindow_20250805.jsp에서 호출)
		function restoreGroup() {
			/* document.querySelector(".group").style.display = "flex"; */
			document.getElementById("introSection").style.display = "block";
			document.getElementById("chatFrameContainer").style.display = "none";
			document.getElementById("chatFrame").src = ""; // iframe 초기화
			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("chatHeader").style.display = "none";
			document.getElementById("toggleBtn").style.display = "block"; // 토글 버튼 표시
			isChatActive = false; // 닉네임 입력 모드로 복구
		}
	</script>

	<!-- 말풍선아이콘 클릭시 채팅창 열고 닫기 -->
	<button id="toggleBtn" onclick="toggleChat()">💬 채팅</button>

	<!-- 대화창 UI 구조 정의 -->

	<div id="chatContainer" style="display: none;">
		<div id="introSection">
			<div id="introHeader">
				<button id="minimizeIntroBtn" class="in" onclick="minimizeChat()">⏷</button>
				<!--  축소 버튼 -->
			</div>
			<div id="chatHeader">
				<button id="minimizeBtn" class="in" onclick="minimizeChat()">⏷</button>
			</div>

			<h2>실시간 채팅</h2>
			<div class="group">
				&nbsp;&nbsp;&nbsp;<label>닉네임</label> <input type="text" name="name"
					id="chatId" class="short" onkeypress="checkEnter(event)">
				<button type="button" class="in" id="closeBtn"
					onclick="chatWinOpen();">들어가기</button>
			</div>
		</div>
		<div id="chatFrameContainer" style="display: none;">
			<iframe id="chatFrame" src="" frameborder="0" width="100%"></iframe>
		</div>


	</div>
</body>
</html>