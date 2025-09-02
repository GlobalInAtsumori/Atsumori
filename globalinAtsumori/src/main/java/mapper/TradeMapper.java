package mapper;

import java.util.List;
import java.util.Map;

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
    
    //페이징된 게시글 목록 조회
    List<TradeVO> selectPagedPosts(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    //페이징용 글 (총)개수
    int countPosts();
    
    //페이징용 글(검색) 개수
    int countPostsByKeyword(@Param("keyword") String keyword, @Param("type") String type);
    
    //검색+페이징
    List<TradeVO> selectPagedPostsByKeyword(
    	@Param("startRow") int startRow,
    	@Param("endRow") int endRow,
    	@Param("keyword") String keyword,
    	@Param("type") String type
    );
    
    //마이페이지
    //로그인한 회원의 '내'글 가져오기
    List<TradeVO> selectPostsByMember(Map<String, Object> paramMap);
    
    //memberNo에 해당하는 글 전체 수 반환
    int countMyPosts(int memberNo);
    
    //거래 승낙 후 status 변화
    void updateTradeStatusToDone(int tradePostNo);
    
    //거래희망 버튼 update(AVILABLE to TRADING)용
    //public void updateStatus(@Param("tradePostNo") int tradePostNo, @Param("status") String status);
    int updateTradeRequest(@Param("tradePostNo") int tradePostNo, @Param("memberNo") int memberNo);
    
    // 내가 거래희망한 글 목록 조회 (페이징 없이)
    List<TradeVO> selectRequestedTradeByMember(@Param("memberNo") int memberNo);
}
