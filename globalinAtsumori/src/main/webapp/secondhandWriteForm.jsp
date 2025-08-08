<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setAttribute("bannerMessage", "✏️中古品売買✏️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✏️中古品売買✏️</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/secondhand.css">
<script type="text/javascript" src="secondhandScript.js"></script>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
	
		<form action="shWriteProc.jsp" method="post" name="shWriteForm" onsubmit="return shWriteSave()">
			<table class="shWrite">
				<tr>
					<td class="textonly">タイトル</td>
					<td class="input">
						<input type="text" maxlength="30" name="tradeTitle">
					</td>
				</tr>
				<tr>
					<td class="textonly">希望価格</td>
					<td class="input">
						<input type="text" maxlength="30" name="cost" id="costCheck" placeholder="数字を入力してください。">					
					</td>
				</tr>
				<tr>
					<td class="textonly">詳細な説明</td>
					<td class="input">
						<textarea name="tradeContent"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="登録">
						<input type="reset" value="書換え">
						<input type="button" value="取消し" onclick="window.location='secondhandMain.jsp'">						
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>