<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 이미 로그인 되어 있으면 메인 페이지로 이동
    String loginID = (String) session.getAttribute("loginID");
    if (loginID != null) {
        response.sendRedirect("mainPage.jsp");
        return;
    }

    // 배너 메시지
    request.setAttribute("bannerMessage", "로그인");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아쯔모리</title>
<link rel="stylesheet" href="../css/style.css">
</head>
<body align="center">
    <div class="wrapper">

        <jsp:include page="../includes/navbar.jsp" />
        <jsp:include page="../includes/banner.jsp" />
        <br> <br> <br>

        <!-- 로그인 폼 -->
        <form action="<%=request.getContextPath()%>/memberone/login" method="post">
            <table class="login-table">
                <tr>
                    <h2 align="center">ログイン</h2>
                </tr>
                <tr>
                    <td class="label">ID</td>
                    <td width="200">&nbsp; <input type="text" name="memberId" class="reg-input" required></td>
                </tr>
                <tr>
                    <td class="label">PW</td>
                    <td width="200">&nbsp; <input type="password" name="password" class="reg-input" required></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" class="reg-btn" value="ログイン">
                    </td>
                </tr>
            </table>
        </form>

        <!-- 로그인 실패 시 메시지 -->
        <div class="error-msg" style="color:red;">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
                    out.print(error);
                }
            %>
        </div>

    </div>
</body>
</html>
