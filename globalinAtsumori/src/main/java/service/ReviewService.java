package service;

import java.sql.Date;

import org.springframework.stereotype.Service;

import domain.ReviewVO;
import dto.ReviewCreateDTO;
import mapper.ReviewMapper;

@Service
public class ReviewService {
	
	private final ReviewMapper reviewMapper;
	
	public ReviewService(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }
	
	public void create(ReviewCreateDTO dto, int userNo) {
        ReviewVO reviewVO = new ReviewVO();
        
        reviewVO.setReviewTitle(dto.getReviewTitle());
        reviewVO.setRestNo(dto.getRestNo());
        reviewVO.setReviewContent(dto.getReviewContent());
        reviewVO.setCreateDate(new Date(System.currentTimeMillis()));
        reviewVO.setMemberNo(userNo);

        reviewMapper.insertReview(reviewVO);
    }
	
}
