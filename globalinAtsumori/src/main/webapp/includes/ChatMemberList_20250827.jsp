<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 멤버 리스트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles_RTC.css">
<style>
    #memberListContainer {
        padding: 10px;
        background-color: var(--control-back-color);
        border: 1px solid var(--border-color);
        border-radius: 5px;
        height: 100%;
        box-sizing: border-box;
    }
    #memberListContainer h3 {
        font-size: 1.2rem;
        color: var(--header-color);
        margin: 0 0 10px 0;
        border-bottom: 1px dashed var(--border-color);
    }
    #memberList ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    #memberList li {
        padding: 8px 10px;
        border-bottom: 1px solid var(--border-color);
        font-size: 0.9rem;
        color: var(--text-color);
        line-height: 1.5;
    }
    #memberList li:last-child {
        border-bottom: none;
    }
    #memberList li:hover {
    background-color: #f0f0f0; /* 호버 효과 */
    }
    
</style>
<script>
    var webSocket;
    var memberListDiv;

    window.onload = function() {
        memberListDiv = document.getElementById("memberList");
        const serverIp = '<%= java.net.InetAddress.getLocalHost().getHostAddress() %>';
        console.log("WebSocket 연결 시도: ws://" + serverIp + ":9090/ChatingServer");
        webSocket = new WebSocket("ws://" + serverIp + ":9090/ChatingServer");

        webSocket.onopen = function(event) {
            console.log("멤버 리스트 WebSocket 연결 성공");
            // 연결 후 즉시 멤버 리스트 요청
            //webSocket.send("requestMemberList|");
        };

        webSocket.onmessage = function(event) {
            console.log("멤버 리스트 메시지 수신: " + event.data);
            if (event.data.startsWith("/members|")) {
                var members = event.data.split("|")[1].split(",");
                if (members.length === 1 && ( members[0] === "없음" || members[0] ==="")) {
                    members = [];
                }
                updateMemberList(members);
            } else if (event.data === "requestMemberList:" || event.data.startsWith("requestMemberList:")) {
                console.log("requestMemberList 무시");
            }
        };

        webSocket.onclose = function(event) {
            console.log("멤버 리스트 WebSocket 종료: 코드=" + event.code + ", 이유=" + event.reason);
        };

        webSocket.onerror = function(event) {
            console.error("멤버 리스트 WebSocket 에러: ", event);
        };
    };

    function updateMemberList(members) {
        console.log("멤버 리스트 업데이트: ", members);
        memberListDiv.innerHTML = "";
        var ul = document.createElement("ul");
        if (members.length === 0) {
            var li = document.createElement("li");
            li.textContent = "현재 접속한 멤버가 없습니다.";
            li.style.color = "gray";
            ul.appendChild(li);
        } else {
            members.forEach(function(member) {
                if (member.trim() !== "" && member !== "없음") {
                    var li = document.createElement("li");
                    li.textContent = member;
                    li.style.cursor = "pointer"; // 클릭 가능 표시 (손 모양 커서)
                    li.onclick = function() {
                        // 수정: chatFrame iframe의 내부 문서에 접근
                        var chatFrameDoc = parent.document.getElementById("chatFrame").contentDocument;
                        if (chatFrameDoc) {
                            var chatMessage = chatFrameDoc.getElementById("chatMessage");
                            if (chatMessage) {
                                chatMessage.value = "/" + member + " "; // "/닉네임 " 입력
                                chatMessage.focus(); // 입력 창에 포커스
                                console.log("귓속말 입력 성공: /" + member + " ");
                            } else {
                                console.error("chatMessage 요소를 찾을 수 없습니다. (chatFrame 내부 확인)");
                            }
                        } else {
                            console.error("chatFrame 문서를 찾을 수 없습니다.");
                        }
                    };
                    ul.appendChild(li);
                }
            });
        }
        memberListDiv.appendChild(ul);
    }
</script>
</head>
<body>
    <div id="memberListContainer" class="chat-container">
        <h3>接続メンバー</h3>
        <div id="memberList"></div>
    </div>
</body>
</html>