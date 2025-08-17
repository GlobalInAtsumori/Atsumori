<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setAttribute("bannerMessage", "✏️中古品売買✏️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✏️中古品売買✏️</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/secondhand.css">
<script type="text/javascript" src="js/secondhandScript.js"></script>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
	
		<form action="/secondhand/write" method="post" name="shWriteForm" enctype="multipart/form-data" onsubmit="return shWriteSave()">
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
	            	<td class="textonly">写真アップロード</td>
	            	<td class="input" style="border:none;">
	                	<input type="file" name="imageFile" accept="image/*">
	            	</td>
	        	</tr>
				<tr class="forCenter">
					<td class="button">
						<input type="submit" value="投稿">
						<input type="reset" value="書換え">
						<input type="button" value="取消し" onclick="window.location='secondhandMain.jsp'">						
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>