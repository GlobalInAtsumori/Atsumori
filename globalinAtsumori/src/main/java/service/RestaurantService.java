package service;

import java.util.List;

import org.springframework.stereotype.Service;

import dto.RestListDTO;
import lombok.RequiredArgsConstructor;
import mapper.RestaurantMapper;

@Service
@RequiredArgsConstructor
public class RestaurantService {
	private final RestaurantMapper restaurantMapper;
	
	public List<RestListDTO> getRestaurantsInBounds(double swLat, double swLng, double neLat, double neLng) {
        return restaurantMapper.findInBounds(swLat, swLng, neLat, neLng);
    }
}
