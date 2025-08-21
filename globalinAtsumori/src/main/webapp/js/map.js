var map;
var markers = [];

function initMap() {
	map = new google.maps.Map(document.getElementById("map"), {
		center: { lat: 37.5665, lng: 126.9780 },
		zoom: 12,
		mapTypeControl: false,
		streetViewControl: false,
		fullscreenControl: false,
		zoomControl: false,
		clickableIcons: false
	});

	// 브라우저에서 현재 위치 요청
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(
			function(position) {
				var userLat = position.coords.latitude;
				var userLng = position.coords.longitude;

				// 지도의 중심을 사용자 위치로 변경
				var userLocation = { lat: userLat, lng: userLng };
				map.setCenter(userLocation);
				map.setZoom(12);
			},
			function() {
				console.warn("사용자가 위치 공유를 거부했거나 오류 발생.");
				// 거부 시 기본 좌표(서울시청) 유지
			}
		);
	} else {
		console.warn("이 브라우저는 Geolocation을 지원하지 않습니다.");
		// 기본 좌표 유지
	}

	google.maps.event.addListener(map, "idle", function() {
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
	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			var restaurants = JSON.parse(xhr.responseText);

			var newMarkers = [];
			document.getElementById("restaurantList").innerHTML = "";
			var svgIconUrl = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBmaWxsPSJjdXJyZW50Q29sb3IiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjI5MSAyMS43MDZMMTIgMjF6TTEyIDIxbC43MDguNzA2YTEgMSAwIDAgMS0xLjQxNyAwbC0uMDA2LS4wMDdsLS4wMTctLjAxN2wtLjA2Mi0uMDYzYTQ4IDQ4IDAgMCAxLTEuMDQtMS4xMDZhNTAgNTAgMCAwIDEtMi40NTYtMi45MDhjLS44OTItMS4xNS0xLjgwNC0yLjQ1LTIuNDk3LTMuNzM0QzQuNTM1IDEyLjYxMiA0IDExLjI0OCA0IDEwYzAtNC41MzkgMy41OTItOCA4LThzOCAzLjQ2MSA4IDhjMCAxLjI0OC0uNTM1IDIuNjEyLTEuMjEzIDMuODdjLS42OTMgMS4yODYtMS42MDQgMi41ODUtMi40OTcgMy43MzVhNTAgNTAgMCAwIDEtMy40OTYgNC4wMTRsLS4wNjIuMDYzbC0uMDE3LjAxN2wtLjAwNi4wMDZ6bTAtOGEzIDMgMCAxIDAgMC02YTMgMyAwIDAgMCAwIDYiIGNsaXAtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg==';

			for (var i = 0; i < restaurants.length; i++) {
				(function(place) {
					var existing = markers.find(m => m.restNo === place.restNo);
					if (existing) {
						// 기존 마커가 있으면 위치만 갱신
						existing.marker.setPosition({ lat: place.latitude, lng: place.longitude });
						newMarkers.push(existing); // 그대로 유지
					} else {
						// 새 마커 생성
						var marker = new google.maps.Marker({
							map: map,
							position: { lat: place.latitude, lng: place.longitude },
							title: place.restName,
							icon: {
								url: svgIconUrl,
								scaledSize: new google.maps.Size(32, 32),
								anchor: new google.maps.Point(16, 32)
							}
						});

						var infoWindow = new google.maps.InfoWindow({
							content:
								"<div style='font-size:14px; line-height:1.4'>" +
								"<strong>" + place.restName + "</strong><br>" +
								place.address +
								"</div>"
						});

						marker.addListener("click", function() {
							// 다른 InfoWindow 닫기 (중복 방지)
							if (window.currentInfoWindow) {
								window.currentInfoWindow.close();
							}
							infoWindow.open(map, marker);
							window.currentInfoWindow = infoWindow;
						});

						newMarkers.push({ restNo: place.restNo, marker: marker, infoWindow: infoWindow });
					}

					var item = document.createElement("div");
					item.className = "restaurant-item";
					item.innerHTML =
						"<strong>" + place.restName + "</strong><br>" +
						place.address + "<br>";

					// 리뷰용 요소 미리 만들어서 숨겨놓기 (초기엔 안 보임)
					var reviewDiv = document.createElement("div");
					reviewDiv.className = "review-info";
					reviewDiv.style.display = "none";  // 처음에는 숨김

					if (place.reviewTitle) {
						reviewDiv.innerHTML =
							"<strong>" + place.reviewTitle + "</strong><br>" +
							"<span>" + place.reviewContent + "</span>";
					} else {
						reviewDiv.textContent = "최근 리뷰가 없습니다.";
					}

					item.appendChild(reviewDiv);
					item.addEventListener("click", function() {
						var reviewVisible = reviewDiv.style.display === "block";

					    if (!reviewVisible) {
					        // 리뷰가 보이지 않으면 리뷰 토글
					        reviewDiv.style.display = "block";
					        item.style.height = "auto";
					    } else {
					        // 리뷰가 이미 보이면 상세 페이지 이동
					        window.location.href = "/restaurant/detail?restNo=" + place.restNo;
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
