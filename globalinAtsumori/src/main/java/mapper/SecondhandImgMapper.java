package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.SecondhandImageVO;

@Mapper
public interface SecondhandImgMapper {
	
	void insertSHImage(SecondhandImageVO vo);
	List<SecondhandImageVO> getSHImage(int tradePostNo);
	
}
