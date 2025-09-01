package mapper;

import domain.BoardCommentVO;
import dto.BoardCommentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface BoardCommentMapper {
    void insertComment(BoardCommentVO comment);
    
    // 이 메서드가 DTO 리스트를 반환하도록 변경
    List<BoardCommentDTO> getCommentsByBoardNo(int boardNo);
    
    int deleteComment(int commentNo);
}