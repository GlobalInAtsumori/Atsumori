package mapper;

import org.apache.ibatis.annotations.Mapper;

import domain.ReviewImageVO;

@Mapper
public interface ReviewImgMapper {

	void insertReviewImg(ReviewImageVO riVO);
}
