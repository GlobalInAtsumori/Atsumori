package service;

import dto.BoardDTO;
import mapper.BoardMapper;
import domain.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.sql.Date;
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

    public List<BoardDTO> getArticles(int startRow, int pageSize) {
        List<BoardVO> voList = boardMapper.getArticles(startRow, pageSize);
        return voList.stream().map(this::convertToDto).collect(Collectors.toList());
    }

    public List<BoardDTO> getArticles(String searchWhat, String searchText, int startRow, int pageSize) {
        List<BoardVO> voList = boardMapper.getArticlesBySearch(searchWhat, searchText, startRow, pageSize);
        return voList.stream().map(this::convertToDto).collect(Collectors.toList());
    }

    public int getArticleCountBySearch(String searchWhat, String searchText) {
        return boardMapper.getArticleCountBySearch(searchWhat, searchText);
    }

    public BoardDTO getArticle(int boardno) {
        BoardVO vo = boardMapper.getArticle(boardno);
        return convertToDto(vo);
    }

    public void insertArticle(BoardDTO article) {
        BoardVO vo = convertToVo(article);
        boardMapper.insertArticle(vo);
    }
    
    public int updateArticle(BoardDTO updateDTO) {
        BoardVO vo = convertToVo(updateDTO);
        return boardMapper.updateArticle(vo);
    }

    // 비밀번호 매개변수를 제거했습니다.
    public int deleteArticle(int boardno) {
        return boardMapper.deleteArticle(boardno);
    }

    // DTO 객체를 VO 객체로 변환하는 도우미 메소드
    private BoardVO convertToVo(BoardDTO dto) {
        if (dto == null) return null;
        BoardVO vo = new BoardVO();
        vo.setBoardno(dto.getBoardno());
        vo.setTitle(dto.getTitle());
        vo.setContent(dto.getContent());
        vo.setMemberno(2); // 추후에 변경

        try {
            if (dto.getCreatedate() != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                vo.setCreatedate(new Date(sdf.parse(dto.getCreatedate()).getTime()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            vo.setCreatedate(new Date(System.currentTimeMillis()));
        }
        return vo;
    }
    
    // VO 객체를 DTO 객체로 변환하는 도우미 메소드
    private BoardDTO convertToDto(BoardVO vo) {
        if (vo == null) return null;
        BoardDTO dto = new BoardDTO();
        dto.setBoardno(vo.getBoardno());
        dto.setTitle(vo.getTitle());
        dto.setContent(vo.getContent());
        dto.setMemberno(vo.getMemberno());

        if (vo.getCreatedate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            dto.setCreatedate(sdf.format(vo.getCreatedate()));
        } else {
            dto.setCreatedate(null);
        }
        return dto;
    }
}
