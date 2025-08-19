package mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import domain.SecondhandVO;

@Mapper
public interface SecondhandMapper {
	// 글 등록
    void insertTradePost(SecondhandVO vo);

    // 이미지 등록
    void insertTradeImage(SecondhandVO vo);

    // 글 수정
    void updateTradePost(SecondhandVO vo);

    // 이미지 수정
    void updateTradeImage(SecondhandVO vo);

    // 글 삭제
    void deleteTradePost(int tradePostNo);

    // 이미지 삭제
    void deleteTradeImage(int tradePostNo);

    // 단일 글 조회
    SecondhandVO selectTradePostById(int tradePostNo);

    // 메인 페이지 리스트 조회
    List<SecondhandVO> selectTradePostList();

    // 페이징용 글 개수
    int countTradePost();
}
