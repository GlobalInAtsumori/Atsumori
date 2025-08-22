package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.ReviewVO;
import dto.ReviewDTO;

@Mapper
public interface ReviewMapper {
	void insertReview(ReviewVO reviewVO);
	
	List<ReviewDTO> findReviewsByRestNo(int restNo);
}
