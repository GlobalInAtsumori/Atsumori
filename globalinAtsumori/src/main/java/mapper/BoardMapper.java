package mapper;

import domain.BoardVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface BoardMapper {
    int getArticleCount();
    List<BoardVO> getArticles(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
    List<BoardVO> getArticlesBySearch(@Param("searchWhat") String searchWhat, @Param("searchText") String searchText, @Param("startRow") int startRow, @Param("pageSize") int pageSize);
    int getArticleCountBySearch(@Param("searchWhat") String searchWhat, @Param("searchText") String searchText);
    BoardVO getArticle(@Param("boardno") int boardno);
    void insertArticle(BoardVO article);
    int updateArticle(BoardVO updateVO);
    // 비밀번호 매개변수를 제거했습니다.
    int deleteArticle(@Param("boardno") int boardno);
}
