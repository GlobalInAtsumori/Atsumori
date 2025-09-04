<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, domain.BoardVO" %>

<html>
<head>
    <title>관리자 게시글 관리</title>
</head>
<body>
<h2>관리자 게시글 관리</h2>

<form method="get">
    검색:
    <select name="searchType">
        <option value="title">제목</option>
        <option value="memberId">작성자ID</option>
        <option value="memberName">작성자이름</option>
    </select>
    <input type="text" name="searchKeyword">
    <input type="submit" value="검색">
</form>

<table border="1">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>게시판 종류</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>신고</th>
        <th>상태</th>
        <th>상태 변경</th>
    </tr>

    <c:forEach var="board" items="${boardList}">
        <tr>
            <td>${board.boardno}</td>
            <td><a href="boardView.jsp?boardno=${board.boardno}">${board.title}</a></td>
            <td>${board.boardType}</td>
            <td>${board.memberName}(${board.memberId})</td>
            <td>${board.createdate}</td>
            <td>${board.reported ? 'O' : ''}</td>
            <td>${board.status}</td>
            <td>
                <form action="updateStatus.do" method="post">
                    <input type="hidden" name="boardno" value="${board.boardno}">
                    <select name="status">
                        <option value="게시됨" ${board.status=='게시됨' ? 'selected' : ''}>게시됨</option>
                        <option value="숨김" ${board.status=='숨김' ? 'selected' : ''}>숨김</option>
                        <option value="삭제" ${board.status=='삭제' ? 'selected' : ''}>삭제</option>
                    </select>
                    <input type="submit" value="변경">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
