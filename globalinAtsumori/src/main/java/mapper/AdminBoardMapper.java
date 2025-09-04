package mapper;

import java.util.List;
import java.util.Map;
import domain.BoardVO;

public interface AdminBoardMapper {
    // 페이징 포함 게시글 목록
    List<BoardVO> getBoardList(Map<String, Object> params);
    
    // 게시글 상태 변경
    void updateBoardStatus(Map<String, Object> params);
    
    // 총 게시글 수 (페이징용)
    int getBoardCount(Map<String, Object> params);
}
