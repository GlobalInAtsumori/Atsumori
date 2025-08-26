package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import domain.TradeVO;

@Mapper
public interface TradeMapper {
	//게시글 등록
    void insertTradePost(TradeVO vo);
    
    //메인페이지 조회(리스트)
    List<TradeVO> getTradeList();
    
    //상세페이지
    TradeVO getTradeDetail(int tradePostNo);
    
    //페이징용 글 개수
    int countTradePost();
    
    //거래희망 버튼 update(AVILABLE to TRADING)용
    void updateStatus(@Param("tradePostNo") int tradePostNo, @Param("status") String status);
}
