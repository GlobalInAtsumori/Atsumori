package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import domain.TradeImageVO;

@Mapper
public interface TradeImgMapper {
	
	//이미지 등록용
	void insertTradeImage(TradeImageVO vo);
	
	//이미지 삭제용
	void deleteTradeImage(int tradePostNo);
	
	//이미지 조회용
	List<TradeImageVO> getTradeImage(int tradePostNo);
	
}
