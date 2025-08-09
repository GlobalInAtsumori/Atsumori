package mapper;

import org.apache.ibatis.annotations.Mapper;

import domain.ReviewVO;

@Mapper
public interface ReviewMapper {
	void insertReview(ReviewVO reviewVO);
}
