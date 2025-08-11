package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dto.RestListDTO;
import lombok.RequiredArgsConstructor;
import service.RestaurantService;

@Controller
@RequiredArgsConstructor
public class RestaurantController { //지도 범위 내 가게 조회, 가게 정보 & 최근 리뷰 조회	
	private final RestaurantService restaurantService;

	@Value("${google.maps.api.key}")
    private String mapApiKey;
	
    @GetMapping("/restaurant/list")
    @ResponseBody
    public List<RestListDTO> getRestaurantList(
            @RequestParam double neLat,
            @RequestParam double neLng,
            @RequestParam double swLat,
            @RequestParam double swLng
    ) {
        return restaurantService.getRestaurantsInBounds(neLat, neLng, swLat, swLng);
    }
    
    @GetMapping("/map")
	public String mapPage(Model model) {
    	model.addAttribute("mapApiKey", mapApiKey);
    	
		return "map";
    }
}
