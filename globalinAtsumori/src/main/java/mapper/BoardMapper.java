package mapper;

import domain.BoardVO;
import dto.BoardDTO; // BoardDTO를 import 합니다.
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface BoardMapper {
    int getArticleCount();
    
    // 반환 타입을 List<BoardDTO>로 변경
    List<BoardDTO> getArticles(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
    
    // 반환 타입을 List<BoardDTO>로 변경
    List<BoardDTO> getArticlesBySearch(@Param("searchWhat") String searchWhat, @Param("searchText") String searchText, @Param("startRow") int startRow, @Param("pageSize") int pageSize);
    
    int getArticleCountBySearch(@Param("searchWhat") String searchWhat, @Param("searchText") String searchText);
    
    // 반환 타입을 BoardDTO로 변경
    BoardDTO getArticle(@Param("boardno") int boardno);
    
    void insertArticle(BoardVO article);
    int updateArticle(BoardVO updateVO);
    int deleteArticle(@Param("boardno") int boardno);
}