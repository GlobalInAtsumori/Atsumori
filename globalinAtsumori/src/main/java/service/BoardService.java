package service;

import dto.BoardDTO;
import mapper.BoardMapper;
import domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BoardService {

    private final BoardMapper boardMapper;

    @Autowired
    public BoardService(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    public int getArticleCount() {
        return boardMapper.getArticleCount();
    }

    // VO가 아닌 DTO 리스트를 반환하도록 변경
    public List<BoardDTO> getArticles(int startRow, int pageSize) {
        return boardMapper.getArticles(startRow, pageSize);
    }

    // VO가 아닌 DTO 리스트를 반환하도록 변경
    public List<BoardDTO> getArticles(String searchWhat, String searchText, int startRow, int pageSize) {
        return boardMapper.getArticlesBySearch(searchWhat, searchText, startRow, pageSize);
    }

    public int getArticleCountBySearch(String searchWhat, String searchText) {
        return boardMapper.getArticleCountBySearch(searchWhat, searchText);
    }

    // VO가 아닌 DTO를 반환하도록 변경
    public BoardDTO getArticle(int boardno) {
        return boardMapper.getArticle(boardno);
    }

    public void insertArticle(BoardDTO article) {
        // DTO를 VO로 변환하는 메소드는 삭제
        boardMapper.insertArticle(convertToVo(article));
    }
    
    public int updateArticle(BoardDTO updateDTO) {
        // DTO를 VO로 변환하는 메소드는 삭제
        return boardMapper.updateArticle(convertToVo(updateDTO));
    }

    public int deleteArticle(int boardno) {
        return boardMapper.deleteArticle(boardno);
    }

    // DTO 객체를 VO 객체로 변환하는 도우미 메소드 (남겨둠)
    private BoardVO convertToVo(BoardDTO dto) {
        if (dto == null) return null;
        BoardVO vo = new BoardVO();
        vo.setBoardno(dto.getBoardno());
        vo.setTitle(dto.getTitle());
        vo.setContent(dto.getContent());
        vo.setMemberno(dto.getMemberno());
        vo.setCreatedate(dto.getCreatedate());
        return vo;
    }
    
    // VO 객체를 DTO 객체로 변환하는 도우미 메소드는 사용하지 않으므로 삭제
}