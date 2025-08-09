package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RestaurantController { //지도 범위 내 가게 조회, 가게 정보 & 최근 리뷰 조회

	@RequestMapping("/map")
	public String map() {
		return "map";
	}
	
	@RequestMapping("/restaurant")
	public String restaurant() {
		return "";
	}
	
}
