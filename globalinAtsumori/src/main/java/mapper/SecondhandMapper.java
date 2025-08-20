package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import domain.SecondhandVO;

@Mapper
public interface SecondhandMapper {
	//게시글 등록
    void insertTradePost(SecondhandVO vo);
    
    //메인페이지 조회(리스트)
    List<SecondhandVO> getSecondhandList();
    
    //상세페이지
    SecondhandVO getSecondhandDetail(int tradePostNo);
    
    //페이징용 글 개수
    int countTradePost();
}
