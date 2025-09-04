<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>댓글 관리</h2>

<form method="get" action="${pageContext.request.contextPath}/admin/board/commentList">
    <select name="searchType">
        <option value="content" ${searchType=='content'?'selected':''}>댓글 내용</option>
        <option value="writer" ${searchType=='writer'?'selected':''}>작성자</option>
    </select>
    <input type="text" name="keyword" value="${keyword}" />
    <label>
        <input type="checkbox" name="reportedOnly" value="Y" ${reportedOnly=='Y'?'checked':''} /> 신고된 댓글만
    </label>
    <button type="submit">검색</button>
</form>

<table border="1" width="100%">
    <thead>
        <tr>
            <th>댓글 번호</th>
            <th>댓글 내용</th>
            <th>작성자</th>
            <th>작성일자</th>
            <th>신고됨</th>
            <th>상태</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="c" items="${list}">
            <tr>
                <td>${c.commentNo}</td>
                <td>${c.content}</td>
                <td>${c.memberName}</td>
                <td>${c.createDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${c.commentNo in c.reportedList}">Y</c:when>
                        <c:otherwise>N</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <select onchange="updateCommentStatus(${c.commentNo}, this.value)">
                        <option value="게시됨" ${c.status=='게시됨'?'selected':''}>게시됨</option>
                        <option value="숨김" ${c.status=='숨김'?'selected':''}>숨김</option>
                        <option value="삭제됨" ${c.status=='삭제됨'?'selected':''}>삭제됨</option>
                    </select>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
function updateCommentStatus(commentNo, status) {
    fetch('${pageContext.request.contextPath}/admin/board/commentStatus', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body: 'commentNo=' + commentNo + '&status=' + status
    }).then(r=>r.text()).then(r=>{
        if(r==='OK') alert('상태 변경 완료');
    });
}
</script>
