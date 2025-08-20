package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.SecondhandImageVO;

@Mapper
public interface SecondhandImgMapper {
	
	//이미지 등록용
	void insertSHImage(SecondhandImageVO vo);
	
	//이미지 조회용
	List<SecondhandImageVO> getSHImage(int tradePostNo);
	
}
