<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setAttribute("bannerMessage", "グルメツアー");
    String mapApiKey = (String) request.getAttribute("mapApiKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>グルメツアー</title>

<script 
    src="https://maps.googleapis.com/maps/api/js?key=<%=mapApiKey%>&libraries=places" 
    async="true"
    defer>
</script>

<script type="module" 
    src="https://unpkg.com/@googlemaps/extended-component-library@0.6/dist/index.min.js">
</script>

<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/reviewWrite.css">
</head>
<body>
<div class="wrapper">
    <jsp:include page="includes/navbar.jsp" />
    <jsp:include page="includes/banner.jsp" />
	<jsp:include page="/includes/MultiChatMain_20250806.jsp" />

    <form action="/review/create" method="post" name="shWriteForm" onsubmit="return validateForm()" enctype="multipart/form-data">
        <table class="shWrite">
            <tr>
                <td class="textonly">店検索</td>
                <td class="input">
                    <gmp-place-autocomplete
                        id="searchInput"
                        placeholder="店を検索"
                        style="width: 100%; padding: 5px; box-sizing: border-box;"
                        fields="displayName,formattedAddress,location">
                    </gmp-place-autocomplete>
                </td>
            </tr>
            <tr>
                <td class="textonly">店名</td>
                <td class="input">
                    <input type="text" id="restName" name="restName" maxlength="100" readonly>
                </td>
            </tr>
            <tr>
                <td class="textonly">店の住所</td>
                <td class="input">
                    <input type="text" id="address" name="address" maxlength="200" readonly>
                </td>
            </tr>
            <tr>
                <td class="textonly">タイトル</td>
                <td class="input">
                    <input type="text" name="reviewTitle" maxlength="100" required>
                </td>
            </tr>
            <tr>
                <td class="textonly">店はどうでしたか？</td>
                <td class="input">
                    <textarea name="reviewContent" required></textarea>
                </td>
            </tr>
            <tr>
	            <td class="textonly">사진 업로드</td>
	            <td class="input">
	                <input type="file" name="imageFile" accept="image/*">
	            </td>
	        </tr>
            <tr class="forCenter">
                <td class="button" colspan="2">
                    <input type="submit" value="登録">
                    <input type="reset" value="書換え">
                </td>
            </tr>
        </table>
        <!-- 숨김 필드는 form 안에 table 밖에 둠 -->
        <input type="hidden" id="latitude" name="latitude" />
        <input type="hidden" id="longitude" name="longitude" />
    </form>
</div>

<script>
    function validateForm() {
        const restName = document.getElementById("restName").value.trim();
        const lat = document.getElementById("latitude").value.trim();
        const lng = document.getElementById("longitude").value.trim();
        if (!restName || !lat || !lng) {
            alert("店を検索して正しい店舗を選択してください。");
            return false;
        }
        return true;
    }

    document.addEventListener("DOMContentLoaded", function () {
        const autocompleteElement = document.getElementById("searchInput");
        if (!autocompleteElement) {
            console.error("検索入力要素が見つかりません");
            return;
        }

        autocompleteElement.addEventListener("gmp-select", async (event) => {
            const placePrediction = event.placePrediction;
            if (!placePrediction) {
                console.error("placePredictionがありません");
                return;
            }

            const place = placePrediction.toPlace();
            await place.fetchFields({ fields: ['displayName', 'formattedAddress', 'location'] });

            const name = place.displayName || "";
            const address = place.formattedAddress || "";
            const location = place.location || null;

            if (!location) {
                console.error("選択された場所に位置情報がありません");
                return;
            }

            document.getElementById("restName").value = name;
            document.getElementById("address").value = address;
            document.getElementById("latitude").value = location.lat();
            document.getElementById("longitude").value = location.lng();
        });
    });
</script>
</body>
</html>
