<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>웹소켓 실시간 채팅</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles_RTC.css">
<style>

#introHeader button, #chatHeader button {
	margin-left: 10px; /* 간격 유지 */
} */

</style>
</head>
<body onload="initChat()">
	<script>
		let isChatActive = false;
		let isMemberVisible = false;
		let currentWidth = 370; // 현재 폭 상태 추적 변수
	
		
		function initChat() {
			console.log("initChat 호출");
			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("chatFrameContainer").style.display = "none";
			document.getElementById("chatHeader").style.display = "none";
			document.getElementById("introSection").style.display = "block";
			document.getElementById("toggleBtn").style.display = "block";
			document.getElementById("chatFrame").src = "";
			document.getElementById("memberFrame").src = "";
			document.getElementById("chatId").value = "";
			isChatActive = false;
			currentWidth = 370; // 초기 폭 설정
		}

		function chatWinOpen() {
			var id = document.getElementById("chatId");
			if (!id.value.trim()) {
				alert("대화명을 입력 후 채팅창을 열어주세요.");
				id.focus();
				return;
			}

			var chatId = encodeURIComponent(id.value);
			var chatFrame = document.getElementById("chatFrame");
			chatFrame.src = "${pageContext.request.contextPath}/includes/ChatWindow_20250806.jsp?chatId="
					+ chatId;
			var memberFrame = document.getElementById("memberFrame");
			memberFrame.src = "${pageContext.request.contextPath}/includes/ChatMemberList_20250827.jsp";

			document.getElementById("introSection").style.display = "none";
			document.getElementById("chatFrameContainer").style.display = "flex";
			document.getElementById("chatContainer").style.width = currentWidth + "px"; // 현재 폭 유지
			document.getElementById("chatHeader").style.display = "flex";
			document.getElementById("toggleBtn").style.display = "none";
			id.value = "";
			isChatActive = true;
			isMemberVisible = false;
			document.getElementById("memberFrame").style.display = "none";
			document.getElementById("chatFrame").style.width = "100%";
            document.getElementById("toggleMemberBtn").textContent = "メンバーリスト";

			chatFrame.onload = function() {
				console.log("chatFrame 로드 완료");
				var chatWindow = chatFrame.contentDocument
						.getElementById("chatWindow");
				if (chatWindow) {
					chatWindow.scrollTop = chatWindow.scrollHeight;
				}
			};
			memberFrame.onload = function() {
				console.log("memberFrame 로드 완료");
			};
		}

		function checkEnter(event) {
			if (event.keyCode === 13) {
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
				container.style.width = currentWidth + "px";  // 현재 폭 복원
				toggleBtn.style.display = "none";
				if (isChatActive) {
					chatHeader.style.display = "flex";
					chatFrameContainer.style.display = "flex";
					introSection.style.display = "none";
				} else {
					chatHeader.style.display = "none";
					chatFrameContainer.style.display = "none";
					introSection.style.display = "block";
					// 창 열릴 때 input에 커서 초점 맞추기
					const chatId = document.getElementById("chatId");
				    if (chatId) {
				        chatId.focus();
				    }

				}
			} else {
				container.style.display = "none";
				toggleBtn.style.display = "block";
			}
			console.log("채팅창 토글: "
					+ (container.style.display === "block" ? "보임" : "숨김"));
		}

		function toggleMemberList() {
			const memberFrame = document.getElementById("memberFrame");
			const toggleMemberBtn = document.getElementById("toggleMemberBtn");
			const chatContainer = document.getElementById("chatContainer");
			const chatFrame = document.getElementById("chatFrame");
			if (isMemberVisible) {
				memberFrame.style.display = "none";
				toggleMemberBtn.textContent = "メンバーリスト";
				chatContainer.style.width = "370px"; // 숨길 때 370px로 복귀
				currentWidth = 370; // 폭 상태 업데이트
				chatFrame.style.width = "100%";
				isMemberVisible = false;
			} else {
				memberFrame.style.display = "block";
				toggleMemberBtn.textContent = "メンバーリスト";
				chatContainer.style.width = "600px"; // 열릴 때 600px로 증가
				currentWidth = 600; // 폭 상태 업데이트
				chatFrame.style.width = "65%";
				memberFrame.style.width = "35%";
				isMemberVisible = true;
			}
			console.log("멤버 리스트 토글: " + (isMemberVisible ? "보임" : "숨김"));
		}

		function minimizeChat() {
			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("toggleBtn").style.display = "block";
			console.log("채팅창 최소화");
		}

		function restoreGroup() {
			console.log("restoreGroup 호출");
			document.getElementById("introSection").style.display = "block";
			document.getElementById("chatFrameContainer").style.display = "none";
			document.getElementById("chatFrame").src = "";
			document.getElementById("memberFrame").src = "";
			document.getElementById("chatContainer").style.display = "none";
			document.getElementById("chatHeader").style.display = "none";
			document.getElementById("toggleBtn").style.display = "block";
			isChatActive = false;
			isMemberVisible = false;
			currentWidth = 370; // 초기 폭으로 복원
		}
	</script>


	<div class="chat-container">
		<button id="toggleBtn" onclick="toggleChat()">💬 チャット</button>
		<div id="chatContainer" style="display: none;">
			<div id="introSection">
				<div id="introHeader">
					<button id="minimizeIntroBtn" onclick="minimizeChat()">⏷</button>
				</div>
				<h2>リアルタイムチャット</h2>
				<div class="group">
					&nbsp;&nbsp;&nbsp;<label>ニックネーム</label> <input type="text" name="name"
						id="chatId" class="short" onkeypress="checkEnter(event)">
					<button type="button" class="in" id="closeBtn"
						onclick="chatWinOpen();">入場</button>
				</div>
			</div>
			<div id="chatHeader" style="display: none;">
				<button id="minimizeBtn" onclick="minimizeChat()">⏷</button>
				<button id="toggleMemberBtn" onclick="toggleMemberList()">メンバーリスト
					</button>
			</div>
			<div id="chatFrameContainer" style="display: none;">
				<iframe id="chatFrame" src="" frameborder="0"></iframe>
				<iframe id="memberFrame" src="" frameborder="0"></iframe>
			</div>
		</div>
	</div>
</body>
</html>