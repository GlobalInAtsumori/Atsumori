<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("bannerMessage", "✏️中古品売買✏️"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>✏️中古品売買✏️</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/trade.css">
<script type="text/javascript" src="js/tradeUpdate.js"></script>
</head>
<body>

	<div class="wrapper">
		<jsp:include page="includes/navbar.jsp" />
		<jsp:include page="includes/banner.jsp" />
		<jsp:include page="/includes/MultiChatMain_20250806.jsp" />
	
		<form action="/trade/update" method="post" name="trWriteForm" enctype="multipart/form-data" onsubmit="return trWriteSave()">
			<input type="hidden" name="tradePostNo" value="${post.tradePostNo}">
			<table class="trWrite">
				<tr>
					<td class="textonly">タイトル</td>
					<td class="input">
						<input type="text" maxlength="30" name="tradeTitle" value="${post.tradeTitle}">
					</td>
				</tr>
				<tr>
					<td class="textonly">希望価格</td>
					<td class="input">
						<input type="text" maxlength="30" name="cost" id="costCheck" placeholder="数字を入力してください。" value="${post.cost}">					
					</td>
				</tr>
				<tr>
					<td class="textonly">詳細な説明</td>
					<td class="input">
						<textarea name="tradeContent">${post.tradeContent}</textarea>
					</td>
				</tr>
				<tr>
	            	<td class="textonly">写真アップロード</td>
	            	<td>
	            		<p class="small">&lt;登録されている写真&gt;</p>
						<div class="imgBox">
							<img alt="등록되어 있는 사진" src="${post.image[0].tradeImgUrl}">
						</div>
	            	</td>
	            	<td class="input" style="border:none;">
	                	<input type="file" name="imageFile" accept="image/*">
	            	</td>
	        	</tr>
				<tr class="forCenter">
					<td class="button">
						<input type="submit" value="修正">
						<input type="reset" value="書換え">
						<input type="button" value="取消し" onclick="window.location='/tradeMain'">						
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>