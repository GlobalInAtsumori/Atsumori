var map;
var markers = [];

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 37.5665, lng: 126.9780 },
        zoom: 14,
        mapTypeControl: false,
        streetViewControl: false,
        fullscreenControl: false,
        zoomControl: false,
        clickableIcons: false
    });

    google.maps.event.addListener(map, "idle", function () {
        updateMarkers();
    });
}

function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].marker.setMap(null);
    }
    markers = [];
}

function updateMarkers() {
    if (!map) return;

    var bounds = map.getBounds();
    if (!bounds) return;

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    var url = "/restaurant/list?neLat=" + ne.lat() + "&neLng=" + ne.lng() +
              "&swLat=" + sw.lat() + "&swLng=" + sw.lng();

    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var restaurants = JSON.parse(xhr.responseText);

            clearMarkers();
            document.getElementById("restaurantList").innerHTML = "";

            // base64 인코딩된 SVG 아이콘 URL
            var svgIconUrl = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBmaWxsPSJjdXJyZW50Q29sb3IiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjI5MSAyMS43MDZMMTIgMjF6TTEyIDIxbC43MDguNzA2YTEgMSAwIDAgMS0xLjQxNyAwbC0uMDA2LS4wMDdsLS4wMTctLjAxN2wtLjA2Mi0uMDYzYTQ4IDQ4IDAgMCAxLTEuMDQtMS4xMDZhNTAgNTAgMCAwIDEtMi40NTYtMi45MDhjLS44OTItMS4xNS0xLjgwNC0yLjQ1LTIuNDk3LTMuNzM0QzQuNTM1IDEyLjYxMiA0IDExLjI0OCA0IDEwYzAtNC41MzkgMy41OTItOCA4LThzOCAzLjQ2MSA4IDhjMCAxLjI0OC0uNTM1IDIuNjEyLTEuMjEzIDMuODdjLS42OTMgMS4yODYtMS42MDQgMi41ODUtMi40OTcgMy43MzVhNTAgNTAgMCAwIDEtMy40OTYgNC4wMTRsLS4wNjIuMDYzbC0uMDE3LjAxN2wtLjAwNi4wMDZ6bTAtOGEzIDMgMCAxIDAgMC02YTMgMyAwIDAgMCAwIDYiIGNsaXAtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg==';

            for (var i = 0; i < restaurants.length; i++) {
                (function (place) {
                    var marker = new google.maps.Marker({
                        map: map,
                        position: { lat: place.latitude, lng: place.longitude },
                        title: place.restName,
                        icon: {
                            url: svgIconUrl,
                            scaledSize: new google.maps.Size(32, 32),
                            anchor: new google.maps.Point(16, 32) // 마커 하단 중앙 기준점
                        }
                    });

                    markers.push({ marker: marker, restNo: place.restNo });

                    var item = document.createElement("div");
					item.className = "restaurant-item";
					item.innerHTML =
					    "<strong>" + place.restName + "</strong><br>" +
					    place.address + "<br>";
					
					// 리뷰용 요소 미리 만들어서 숨겨놓기 (초기엔 안 보임)
					var reviewDiv = document.createElement("div");
					reviewDiv.className = "restaurant-review";
					reviewDiv.style.display = "none";  // 처음에는 숨김
					reviewDiv.textContent = place.reviewTitle || "최근 리뷰가 없습니다.";
					item.appendChild(reviewDiv);
					
					item.addEventListener("click", function () {
					    // 클릭하면 지도 이동
					    map.panTo(marker.getPosition());
					    map.setZoom(16);
					
					    // 리뷰 영역 보이기/숨기기 토글
					    if (reviewDiv.style.display === "none") {
					        reviewDiv.style.display = "block";  // 리뷰 보이게
					        item.style.height = "auto";  // 아이템 크기 자동 조절 (필요시 CSS로 조절 가능)
					    } else {
					        reviewDiv.style.display = "none";   // 다시 숨기기
					        item.style.height = "";  // 기본 높이로 복구
					    }
					});

                    document.getElementById("restaurantList").appendChild(item);
                })(restaurants[i]);
            }
        }
    };
    xhr.send();
}

window.initMap = initMap;
