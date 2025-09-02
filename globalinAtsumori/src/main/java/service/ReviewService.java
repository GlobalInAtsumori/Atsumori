package service;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import domain.RestaurantVO;
import domain.ReviewImageVO;
import domain.ReviewVO;
import dto.MyReviewDTO;
import dto.ReviewCreateDTO;
import dto.ReviewDTO;
import lombok.RequiredArgsConstructor;
import mapper.RestaurantMapper;
import mapper.ReviewImgMapper;
import mapper.ReviewMapper;

@Service
@RequiredArgsConstructor
public class ReviewService {
	
	private final ReviewMapper reviewMapper;
	private final RestaurantMapper restaurantMapper;
	private final ReviewImgMapper reviewImgMapper;
	private final S3Service s3service;
	
	public void create(ReviewCreateDTO dto, int userNo) throws IOException{
		
		RestaurantVO restaurantVO = new RestaurantVO();
		ReviewVO reviewVO = new ReviewVO();
		
		Integer restNo = restaurantMapper.findRestNoByNameAndAddress(dto.getRestName(), dto.getAddress());
		
		if(restNo == null) {
			restaurantVO.setRestName(dto.getRestName());
	        restaurantVO.setAddress(dto.getAddress());
	        System.out.println(dto.getRestName());
	        System.out.println(dto.getAddress());
	        System.out.println(dto.getLatitude());
	        System.out.println(dto.getLongitude());
	        restaurantVO.setLongitude(Double.parseDouble(dto.getLongitude()));
	        restaurantVO.setLatitude(Double.parseDouble(dto.getLatitude()));
	        
	        restaurantMapper.insertRestuarant(restaurantVO); //식당 추가
	        
	        restNo = restaurantVO.getRestNo();
		}
        
        reviewVO.setReviewTitle(dto.getReviewTitle());
        reviewVO.setRestNo(restNo);
        reviewVO.setReviewContent(dto.getReviewContent());
        reviewVO.setCreateDate(new Date(System.currentTimeMillis()));
        reviewVO.setMemberNo(userNo);

        reviewMapper.insertReview(reviewVO); //리뷰 추가
        
        if(dto.getImageFile() != null && !dto.getImageFile().isEmpty()) {
        	ReviewImageVO riVO = new ReviewImageVO();
        	String url = null;
        	url = s3service.uploadFile(dto.getImageFile());
        
        	
        	riVO.setReviewImgUrl(url);
            riVO.setReviewNo(reviewVO.getReviewNo());
            
            reviewImgMapper.insertReviewImg(riVO); //리뷰 이미지 추가
        }
    }
	
	public MyReviewDTO getMyReviewList(String memberId, int page, int size){
		int offset = (page - 1) * size;
        List<ReviewDTO> reviewList = reviewMapper.myReviewPaging(memberId, size, offset);
        int totalReviews = reviewMapper.countReviewsByMemberNo(memberId);
        int totalPages = (int) Math.ceil((double) totalReviews / size);
        
        MyReviewDTO dto = new MyReviewDTO();
        dto.setReviewList(reviewList);
        dto.setTotalReviews(totalReviews);
        dto.setTotalPages(totalPages);
        dto.setCurrentPage(page);
        
        return dto;
	}
	
}
