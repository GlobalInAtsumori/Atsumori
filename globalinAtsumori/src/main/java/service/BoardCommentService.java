package service;

import domain.BoardCommentVO;
import dto.BoardCommentDTO;
import mapper.BoardCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BoardCommentService {
    @Autowired
    private BoardCommentMapper boardCommentMapper;
    
    // 댓글 목록을 가져옵니다. Mapper가 이미 DTO를 반환하므로 바로 리턴합니다.
    public List<BoardCommentDTO> getCommentsByBoardNo(int boardNo) {
        return boardCommentMapper.getCommentsByBoardNo(boardNo);
    }

    // 댓글을 작성합니다.
    public void addComment(BoardCommentDTO commentDto) {
        BoardCommentVO commentVo = convertToVo(commentDto);
        boardCommentMapper.insertComment(commentVo);
    }
    
    // 댓글을 삭제합니다.
    public int deleteComment(int commentNo) {
        return boardCommentMapper.deleteComment(commentNo);
    }

    // DTO 객체를 VO 객체로 변환하는 도우미 메서드
    private BoardCommentVO convertToVo(BoardCommentDTO dto) {
        BoardCommentVO vo = new BoardCommentVO();
        vo.setCommentNo(dto.getCommentNo());
        vo.setContent(dto.getContent());
        vo.setBoardNo(dto.getBoardNo());
        vo.setMemberNo(dto.getMemberNo());
        return vo;
    }

    // VO 객체를 DTO 객체로 변환하는 도우미 메서드 (현재는 사용하지 않지만, 추후 필요할 수 있어 남겨둡니다.)
    private BoardCommentDTO convertToDto(BoardCommentVO vo) {
        BoardCommentDTO dto = new BoardCommentDTO();
        dto.setCommentNo(vo.getCommentNo());
        dto.setContent(vo.getContent());
        dto.setBoardNo(vo.getBoardNo());
        dto.setMemberNo(vo.getMemberNo());
        
        if (vo.getCreateDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            dto.setCreateDate(sdf.format(vo.getCreateDate()));
        }
        return dto;
    }
}