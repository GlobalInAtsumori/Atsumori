package service;

import domain.BoardCommentVO;
import dto.BoardCommentDTO;
import mapper.BoardCommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp; // Timestamp를 import 합니다.
import java.util.List;

@Service
public class BoardCommentService {

    @Autowired
    private BoardCommentMapper boardCommentMapper;
    
    public List<BoardCommentDTO> getCommentsByBoardNo(int boardNo) {
        return boardCommentMapper.getCommentsByBoardNo(boardNo);
    }

    public void addComment(BoardCommentDTO commentDto) {
        BoardCommentVO commentVo = convertToVo(commentDto);
        boardCommentMapper.insertComment(commentVo);
    }
    
    public int deleteComment(int commentNo) {
        return boardCommentMapper.deleteComment(commentNo);
    }

    private BoardCommentVO convertToVo(BoardCommentDTO dto) {
        BoardCommentVO vo = new BoardCommentVO();
        vo.setCommentNo(dto.getCommentNo());
        vo.setContent(dto.getContent());
        vo.setBoardNo(dto.getBoardNo());
        vo.setMemberNo(dto.getMemberNo());
        // Timestamp 객체를 그대로 사용
        vo.setCreateDate(dto.getCreateDate());
        return vo;
    }
}