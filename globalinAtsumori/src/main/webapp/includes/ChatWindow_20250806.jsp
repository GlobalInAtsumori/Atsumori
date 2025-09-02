<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%
String serverIp = InetAddress.getLocalHost().getHostAddress();
request.setAttribute("serverIp", serverIp);
%>
<html>
<head>
<title>웹소켓 채팅</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles_RTC.css">
<script>
	const serverIp = '<%=serverIp%>';
	var chatWindow, chatMessage, chatId, chatIdDisplay, webSocket;
	var lastScrollTop = 0; // 스크롤 위치 추적 변수
	var isAutoScrollEnabled = true; // 자동 스크롤 활성화 플래그 (오타 수정)

	function getQueryParam(param) {
	    const urlParams = new URLSearchParams(window.location.search);
	    return urlParams.get(param);
	}

	window.onload = function() {
		chatWindow = document.getElementById("chatWindow");
		chatMessage = document.getElementById("chatMessage");
		chatIdDisplay = document.getElementById("chatIdDisplay");
		
		chatId = getQueryParam("chatId");
		if (chatId && chatIdDisplay) {
			chatIdDisplay.value = chatId;
		} else {
			console.warn("chatId 또는 chatIdDisplay가 정의되지 않았습니다.");
		}
		
		// 창 열릴 때 input에 커서 초점 맞추기
	    if (chatMessage) {
	        chatMessage.focus();
	    }
		
		webSocket = new WebSocket("ws://" + serverIp + ":9090/ChatingServer");
		console.log("채팅 WebSocket 연결 시도: ws://" + serverIp + ":9090/ChatingServer");
		
		webSocket.onopen = function(event) {
			console.log("채팅 WebSocket 연결 성공: " + chatId);
			webSocket.send("/join|" + chatId);
		};

		webSocket.onclose = function(event) {
			console.log("채팅 WebSocket 종료: 코드=" + event.code + ", 이유=" + event.reason);
			chatWindow.innerHTML += "웹소켓 서버가 종료되었습니다.<br/>";
			window.parent.restoreGroup();
		};

		webSocket.onerror = function(event) {
			console.error("채팅 WebSocket 에러: ", event);
			alert("채팅 중 에러가 발생하였습니다.");
			chatWindow.innerHTML += "채팅 중 에러가 발생하였습니다.<br/>";
		};
	
		
		webSocket.onmessage = function(event) {
            console.log("채팅 메시지 수신: " + event.data);
            if (event.data.startsWith("/members|")) {
                console.log("멤버 리스트 메시지 무시: " + event.data);
            } else if (event.data === "requestMemberList:") {
                // "requestMemberList:"는 무시하고 화면에 출력하지 않음
                console.log("requestMemberList 요청 무시");
            } else {
                //var [sender, content] = event.data.split("|");
                
                //
                let parts = event.data.split("|");
                let sender = parts[0];
                let content = parts.slice(1).join("|");
                //
                
                if (sender === "/join") {
                    chatWindow.innerHTML += "<div style='text-align: center; color: green;'>" + content + "님이 입장했습니다.</div>";
                } else if (sender === "/leave") {
                    chatWindow.innerHTML += "<div style='text-align: center; color: red;'>" + content + "님이 퇴장했습니다.</div>";
                } else if (content.match("/")) {
                    if (content.match("/" + chatId)) {
                        var temp = content.replace("/" + chatId, "[귓속말] : ");
                        chatWindow.innerHTML += "<div>" + sender + ": " + temp + "</div>";
                    }
                } else if (content.startsWith("/image|")) {
                	//
                	let imageParts = content.split("|");
                	let mimeType = imageParts[1];
                	let base64Image = imageParts[2];
            		//
            		
                	//var base64Image = content.split("|")[1];
            		chatWindow.innerHtml += "<div>" + sender + ": <img src='data:image/png;base64," + base64Image + "' style='max-width: 200px;'></div>";
                } else {
                    chatWindow.innerHTML += "<div>" + sender + ": " + content + "</div>";
                }
                // 새로운 메시지 추가 후 스크롤 조정
                adjustScroll();
            }
        };
	};

	function sendMessage() {
		if (chatMessage.value.trim() === "") return;
		chatWindow.innerHTML += "<div class='myMsg'>" + chatMessage.value + "</div>";
		webSocket.send(chatId + '|' + chatMessage.value);
		chatMessage.value = "";
		// 메시지 송신 시 항상 맨 아래로 스크롤
	    chatWindow.scrollTop = chatWindow.scrollHeight; // 강제 맨 아래 이동
		// 자동 스크롤 상태 유지
	    isAutoScrollEnabled = true;
	}
	
	// 이미지 업로드 및 전송 함수
	function sendImage() {
		var fileInput = document.getElementById("imageInput");
		var file = fileInput.files[0];
		if (!file) {
			alert("이미지를 선택하세요.");
			return;
		}
		if (file.size > 10 * 1024 * 1024) { // 5MB 제한 //
			alert("이미지 크기가 너무 큽니다. 5MB 이하로 선택하세요.");
			return;
		}
		var reader = new FileReader();
		reader.onload = function(e) {
			let base64Image = e.target.result.split(",")[1]; // base64 데이터 추출
			let mimeType = file.type; //
			if(webSocket.readyState === WebSocket.OPEN) { // 세션 상태 확인
			webSocket.send(chatId + "|/image|" + mimeType + "|" + base64Image);
			chatWindow.innerHTML += "<div class='myMsg'><img src='data:"+mimeType+";base64,"+base64Image+"' style='max-width: 200px;'></div>"; // 내 화면에 표시 //
			adjustScroll();
			} else {
				alert("웹소켓 연결이 닫혔습니다. 다시 연결하세요.");
			}
		};
		reader.readAsDataURL(file);
		fileInput.value= ""; //입력 초기화
	}
	
	function insertEmoji(emoji) {
		chatMessage.value += emoji;
		chatMessage.focus();
	}
	
	
	function disconnect() {
		webSocket.send("/leave|" + chatId);
		webSocket.close();
	}

	function enterKey() {
		if (window.event.keyCode == 13) {
			sendMessage();
		}
	}

	function minimizeChatFromIframe() {
		window.parent.minimizeChat();
	}
	
	
	// 스크롤 조정 함수
	function adjustScroll() {
	    if (isAutoScrollEnabled) {
	        // 자동 스크롤이 활성화된 경우 항상 맨 아래로 이동
	        chatWindow.scrollTop = chatWindow.scrollHeight;
	    }
	    // 스크롤 위치 감지 (onscroll 이벤트 바인딩)
	    chatWindow.onscroll = function() {
	        const currentScrollTop = chatWindow.scrollTop;
	        const isAtBottom = chatWindow.scrollHeight - chatWindow.clientHeight <= currentScrollTop + 20;
	        if (isAtBottom && !isAutoScrollEnabled) {
	            // 맨 아래로 돌아오면 자동 스크롤 재활성화
	            isAutoScrollEnabled = true;
	        } else if (currentScrollTop < lastScrollTop && isAutoScrollEnabled) {
	            // 위로 스크롤하면 자동 스크롤 비활성화
	            isAutoScrollEnabled = false;
	        }
	        lastScrollTop = currentScrollTop; // 현재 스크롤 위치 갱신
	    };
	}
	
</script>
</head>
<body>
	<div class="chat-container">
		<div id="chatContainer2">
			<div class="group">
				<label>참가 대화명</label> <input type="text" id="chatIdDisplay" readonly>
			</div>
			<div id="chatWindow"></div>
			<div class="inputContainer">
				<div>
					<input type="text" id="chatMessage" onkeyup="enterKey();">
					<button id="sendBtn" onclick="sendMessage();">전송</button>
					<button id="closeBtn" onclick="disconnect();">채팅 종료</button><br>
					<!--  이미지 송신 작업 보류
					<input type="file" id="imageInput" accept="image/*" style="display: none;">
					<button onclick="document.getElementById('imageInput').click();">📷</button>
					<button onclick="sendImage();">이미지 전송</button> -->
					<!-- 이모티콘 버튼 -->
					<button onclick="insertEmoji('😊')">😊</button>
                    <button onclick="insertEmoji('😂')">😂</button>
                    <button onclick="insertEmoji('❤️')">❤️</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>