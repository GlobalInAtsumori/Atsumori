package controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/ChatingServer")
public class ChatController {
    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
    private static Map<Session, String> users = Collections.synchronizedMap(new HashMap<Session, String>());

    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        System.out.println("웹소켓 연결: " + session.getId());
        
        // 새 세션 연결 시 즉시 멤버 리스트 전송
        try {
        	broadcastMemberList();
        } catch (IOException e) {
        	e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("메시지 수신: " + session.getId() + ": " + message);
        if (message.startsWith("/join|")) {
            String nick = message.split("\\|")[1];
            if (nick != null && !nick.trim().isEmpty()) {
                users.put(session, nick);
                System.out.println("사용자 입장: " + nick);
                // 멤버 리스트를 모든 클라이언트에 브로드캐스트
                broadcastMemberList();
                
                // 새로 입장한 사용자에게 즉시 멤버 리스트 전송
                if (session.isOpen()) {
                	StringBuilder memberList = new StringBuilder("/members|");
                	synchronized (users) {
                		if(users.isEmpty()) {
                			memberList.append("없음");
                		} else {
                			for (String n : users.values()) {
                				memberList.append(n).append(",");
                			}
                			memberList.setLength(memberList.length()-1);
                		}
					}
                	session.getBasicRemote().sendText(memberList.toString());
                }
                String joinMsg = "/join|" + nick;
                broadcast(joinMsg, session);
            }
        } else if (message.startsWith("/leave|")) {
            String nick = message.split("\\|")[1];
            if (nick != null && users.containsValue(nick)) {
                users.remove(session);
                System.out.println("사용자 퇴장: " + nick);
                broadcastMemberList();
                String leaveMsg = "/leave|" + nick;
                broadcast(leaveMsg, session);
            }
           
        } else if (message.startsWith("/requestMemberList|")) {
        	//클라이언트가 멤버 리스트를 요청한 경우, 브로드캐스트하지 않고 요청한 클라이언트에게만 전송
        	StringBuilder memberList = new StringBuilder("/members|");
        	synchronized (users) {
        		if(users.isEmpty()) {
        			memberList.append("없음");
        		} else {
        			for (String nick : users.values()) {
        				memberList.append(nick).append(",");
        			}
        			memberList.setLength(memberList.length()-1);
        		}
        	}
        	if (session.isOpen()) {
        		session.getBasicRemote().sendText(memberList.toString());
        	} 
        
        } else if (message.startsWith("/image|")) {
        	broadcast(message,session); //
        } else {
        	broadcast(message, session);
        }
    }

    private void broadcast(String message, Session session) throws IOException {
        synchronized (clients) {
            for (Session client : clients) {
                if (!client.equals(session) && client.isOpen()) {
                    System.out.println("브로드캐스트 전송: " + message + " to " + client.getId());
                    client.getBasicRemote().sendText(message);
                }
            }
        }
    }

    private void broadcastMemberList() throws IOException {
        StringBuilder memberList = new StringBuilder("/members|");
        synchronized (users) {
            if (users.isEmpty()) {
                memberList.append("없음");
            } else {
                for (String nick : users.values()) {
                    memberList.append(nick).append(",");
                }
                memberList.setLength(memberList.length() - 1);
            }
        }
        String listMsg = memberList.toString();
        System.out.println("멤버 리스트 브로드캐스트: " + listMsg);
        synchronized (clients) {
            for (Session client : clients) {
                if (client.isOpen()) {
                    client.getBasicRemote().sendText(listMsg);
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        String nick = users.remove(session);
        if (nick != null) {
            try {
                System.out.println("웹소켓 종료, 사용자 제거: " + nick);
                // 세션이 닫힌 후에도 열려 있는 클라이언트에게만 브로드캐스트
                synchronized (clients) {
                	for (Session client : clients) {
	                	if(client.isOpen()) {
	                		broadcastMemberList(); // 열려 있는 세션에만 전송
	                		String leaveMsg = "/leave|" + nick;
	                		broadcast(leaveMsg, session);
	                		break; // 한 번만 호출하도록 최적화
                	}
                }
              }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        clients.remove(session);
        System.out.println("웹소켓 종료: " + session.getId());
    }

    @OnError
    public void onError(Throwable e) {
        System.out.println("에러 발생");
        e.printStackTrace();
    }
}