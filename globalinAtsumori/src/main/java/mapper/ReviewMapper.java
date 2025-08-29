package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import domain.ReviewVO;
import dto.ReviewDTO;

@Mapper
public interface ReviewMapper {
	void insertReview(ReviewVO reviewVO);
	
	List<ReviewDTO> reviewPaging(
		    @Param("restNo") int restNo,
		    @Param("limit") int limit,
		    @Param("offset") int offset
		);
	
	int countReviewsByRestNo(int restNo);
	
	List<ReviewVO> myReviewPaging(
			@Param("memberNo") int memberNo,
		    @Param("limit") int limit,
		    @Param("offset") int offset
		);
}
