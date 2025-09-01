package service;

import java.util.List;

import org.springframework.stereotype.Service;

import domain.RestaurantVO;
import dto.RestDetailDTO;
import dto.RestListDTO;
import dto.ReviewDTO;
import lombok.RequiredArgsConstructor;
import mapper.RestaurantMapper;
import mapper.ReviewMapper;

@Service
@RequiredArgsConstructor
public class RestaurantService {
	private final RestaurantMapper restaurantMapper;
	private final ReviewMapper reviewMapper;
	
	public List<RestListDTO> getRestaurantsInBounds(double swLat, double swLng, double neLat, double neLng) {
        return restaurantMapper.findInBounds(swLat, swLng, neLat, neLng);
    }
	
	public RestDetailDTO getRestDetail(int restNo, int page, int size) {
		
        RestaurantVO restaurantVO = restaurantMapper.findRestaurantByNo(restNo);
        
        int offset = (page - 1) * size;
        List<ReviewDTO> reviewList = reviewMapper.reviewPaging(restNo, size, offset);
        int totalReviews = reviewMapper.countReviewsByRestNo(restNo);
        int totalPages = (int) Math.ceil((double) totalReviews / size);

        RestDetailDTO dto = new RestDetailDTO();
        dto.setRestNo(restaurantVO.getRestNo());
        dto.setRestName(restaurantVO.getRestName());
        dto.setAddress(restaurantVO.getAddress());
        dto.setLongitude(restaurantVO.getLongitude());
        dto.setLatitude(restaurantVO.getLatitude());
        dto.setReviewList(reviewList);
        dto.setTotalReviews(totalReviews);
        dto.setTotalPages(totalPages);
        dto.setCurrentPage(page);
        
        return dto;
	}
}
