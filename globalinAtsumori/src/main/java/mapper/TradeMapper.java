package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import domain.TradeVO;

@Mapper
public interface TradeMapper {
	//게시글 등록
    void insertTradePost(TradeVO vo);
    
    //글 수정
    void updateTradePost(TradeVO vo);
    
    //글 삭제
    void deleteTradePost(int tradePostNo);
    
    //메인페이지 조회(리스트)
    List<TradeVO> getTradeList();
    
    //상세페이지
    TradeVO getTradeDetail(int tradePostNo);
    
    // 페이징된 게시글 목록 조회
    List<TradeVO> selectPagedPosts(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    //페이징용 글 (총)개수
    int countPosts();
    
    //거래희망 버튼 update(AVILABLE to TRADING)용
    public void updateStatus(@Param("tradePostNo") int tradePostNo, @Param("status") String status);
    
}
