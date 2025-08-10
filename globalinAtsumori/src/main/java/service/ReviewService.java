package service;

import java.sql.Date;

import org.springframework.stereotype.Service;

import domain.RestaurantVO;
import domain.ReviewVO;
import dto.ReviewCreateDTO;
import lombok.RequiredArgsConstructor;
import mapper.RestaurantMapper;
import mapper.ReviewMapper;

@Service
@RequiredArgsConstructor
public class ReviewService {
	
	private final ReviewMapper reviewMapper;
	private final RestaurantMapper restaurantMapper;
	
	public void create(ReviewCreateDTO dto, int userNo) {
		RestaurantVO restaurantVO = new RestaurantVO();
        ReviewVO reviewVO = new ReviewVO();
        
        restaurantVO.setRestName(dto.getRestName());
        restaurantVO.setAddress(dto.getAddress());
        System.out.println(dto.getRestName());
        System.out.println(dto.getAddress());
        System.out.println(dto.getLatitude());
        System.out.println(dto.getLongitude());
        restaurantVO.setLongitude(Double.parseDouble(dto.getLongitude()));
        restaurantVO.setLatitude(Double.parseDouble(dto.getLatitude()));
        
        restaurantMapper.insertRestuarant(restaurantVO); //식당 추가
        
        reviewVO.setReviewTitle(dto.getReviewTitle());
        reviewVO.setRestNo(restaurantVO.getRestNo());
        reviewVO.setReviewContent(dto.getReviewContent());
        reviewVO.setCreateDate(new Date(System.currentTimeMillis()));
        reviewVO.setMemberNo(userNo);

        reviewMapper.insertReview(reviewVO); //리뷰 추가
    }
	
}
