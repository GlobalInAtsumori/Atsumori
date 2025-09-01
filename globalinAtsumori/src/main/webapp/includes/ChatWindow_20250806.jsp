<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 서버 PC IP 정보 get -->
<%@ page import="java.net.InetAddress" %>
<%
	String serverIp = InetAddress.getLocalHost().getHostAddress();
	request.setAttribute("serverIp", serverIp);
%>
	
<html>
<head>
<title>웹소켓 채팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_RTC.css">

<script>
	const serverIp = '<%= serverIp %>';
	var chatWindow, chatMessage, chatId, chatIdDisplay;

	function getQueryParam(param) {
	    const urlParams = new URLSearchParams(window.location.search);
	    return urlParams.get(param);
	}
			
	// 채팅창이 열리면 대화창, 메시지 입력창, 대화명 표시란으로 사용할 DOM 객체 저장
	window.onload = function() {
		chatWindow = document.getElementById("chatWindow");
		chatMessage = document.getElementById("chatMessage");
		chatIdDisplay  =  document.getElementById("chatIdDisplay");
		
		chatId = getQueryParam("chatId"); // URL에서 chatId 가져오기
	    
		if (chatId && chatIdDisplay) {
	        chatIdDisplay.value = chatId; // chatIdDisplay에 값 설정
	    } else {
/* 	    	console.error("chatId 또는 chatIdDisplay가 정의되지 않았습니다."); */
	    	console.warn("chatId 또는 chatIdDisplay가 정의되지 않았습니다.");
	    }
	}
	    // 웹소켓 초기화 코드
	    webSocket = new WebSocket("ws://" + serverIp + ":9090/ChatingServer");
	
	// 채팅창 스크롤
	window.setInterval(function() {
		var elem = document.getElementById('chatWindow');
		elem.scrollTop = elem.scrollHeight;
	}, 0);
	
	// WebSocket 이벤트 핸들러 설정
	// 웹소켓 서버에 연결됐을 때 실행
	webSocket.onopen = function(event) {
	/* 	chatWindow.innerHTML += "웹소켓 서버에 연결되었습니다.<br/>"; */
		// 입장 알림: 서버에 /join|chatId 메시지 전송
		webSocket.send("/join|" + chatId);
	};

	// 웹소켓이 닫혔을 때(서버와의 연결이 끊겼을 때) 실행
	webSocket.onclose = function(event) {
		chatWindow.innerHTML += "웹소켓 서버가 종료되었습니다.<br/>";
        // 부모 창의 restoreGroup 호출
        window.parent.restoreGroup();
	};

	// 에러 발생 시 실행
	webSocket.onerror = function(event) {
		alert(event.data);
		chatWindow.innerHTML += "채팅 중 에러가 발생하였습니다.<br/>";
	};

	// 메시지를 받았을 때 실행
	webSocket.onmessage = function(event) {
		var message = event.data.split("|"); // 대화명과 메시지 분리
		var sender = message[0]; // 보낸 사람의 대화명
		var content = message[1]; // 메시지 내용
			
		if (content != "") {
			if ( sender == "/join"){
				// 입장 알림 처리
				chatWindow.innerHTML += "<div style='text-align: center; color: green;'>" + content + "님이 입장했습니다.</div>";
			} else if (sender === "/leave") {
				// 퇴장 알림 처리
				chatWindow.innerHTML += "<div style='text-align: center; color: red;'>" + content + "님이 퇴장했습니다.</div>";
			} else if (content.match("/")) { // 귓속말
				if (content.match(("/" + chatId))) { // 나에게 보낸 메시지만 출력
					var temp = content.replace(("/" + chatId), "[귓속말] : ");
					chatWindow.innerHTML += "<div>" + sender + "" + temp
							+ "</div>";
				}
			} else { // 일반 대화
				chatWindow.innerHTML += "<div>" + sender + " : " + content
						+ "</div>";
		}
	}
}
	// 메시지 전송
	function sendMessage() {
		// 대화창에 표시
		chatWindow.innerHTML += "<div class='myMsg'>" + chatMessage.value
				+ "</div>"
		webSocket.send(chatId + '|' + chatMessage.value); // 서버로 전송
		chatMessage.value = ""; // 메시지 입력창 내용 지우기
		chatWindow.scrollTop = chatWindow.scrollHeight; // 대화창 스크롤
	}

	// 서버와의 연결 종료
	function disconnect() {
		// 퇴장 알림: 서버에 /leave|chatId 메시지 전송
		webSocket.send("/leave|" + chatId);
		webSocket.close();
	}

	// 엔터 키 입력 처리
	function enterKey() {
		if (window.event.keyCode == 13) { // 13은 'Enter' 키의 코드값
			sendMessage();
		}
	}
	
	function minimizeChatFromIframe() {
        window.parent.minimizeChat();
    }
</script>

</head>

<body>

<div class="chat-container">
	<!-- 초기 화면 -->
<!-- 	<div>
    	<h2>채팅에 오신 것을 환영합니다!</h2>
	</div> -->
	<!-- 대화창 UI 구조 정의 -->
	<div id="chatContainer2" >
			<div id="chatHeader">
				<button id="minimizeBtn" onclick="minimizeChatFromIframe()">⏷</button>
			</div>
	<div class="group">
			<label>참가 대화명</label> 
<!-- 			<input type="text" id="chatIdDisplay" width=30 readonly> -->
			<input type="text" id="chatIdDisplay" width=30 readonly>
			</div>
		<div id="chatWindow"></div>
		 <div class="inputContainer">
		<div>
			<input type="text" id="chatMessage" onkeyup="enterKey();">
			<button id="sendBtn" onclick="sendMessage();">전송</button>
			<button id="closeBtn" onclick="disconnect();">채팅 종료</button>
		</div>
	</div>
	</div>
	</div>
</body>
</html>