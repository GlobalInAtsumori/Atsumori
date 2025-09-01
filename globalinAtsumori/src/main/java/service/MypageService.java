package service;

import mapper.MypageMapper;
import domain.BoardVO;
import domain.BoardCommentVO;
import dto.BoardDTO;
import dto.BoardCommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.sql.Timestamp;

@Service
public class MypageService {

    private final MypageMapper mypageMapper;

    @Autowired
    public MypageService(MypageMapper mypageMapper) {
        this.mypageMapper = mypageMapper;
    }

    private BoardDTO convertToDto(BoardVO vo) {
        if (vo == null) return null;
        BoardDTO dto = new BoardDTO();
        dto.setBoardno(vo.getBoardno());
        dto.setTitle(vo.getTitle());
        dto.setContent(vo.getContent());
        dto.setMemberno(vo.getMemberno());
        dto.setCreatedate(vo.getCreatedate());
        return dto;
    }
    
    // BoardCommentVO를 BoardCommentDTO로 변환하는 도우미 메서드 수정
    private BoardCommentDTO convertCommentToDto(BoardCommentVO vo) {
        if (vo == null) return null;
        BoardCommentDTO dto = new BoardCommentDTO();
        dto.setCommentNo(vo.getCommentNo());
        dto.setContent(vo.getContent());
        dto.setCreateDate(vo.getCreateDate());
        dto.setBoardNo(vo.getBoardNo());
        dto.setMemberNo(vo.getMemberNo());
        return dto;
    }
    
    public List<BoardDTO> getArticlesByMemberNo(int memberNo) {
        List<BoardVO> voList = mypageMapper.getArticlesByMemberNo(memberNo);
        return voList.stream().map(this::convertToDto).collect(Collectors.toList());
    }

    public List<BoardCommentDTO> getCommentsByMemberNo(int memberNo) {
        List<BoardCommentVO> voList = mypageMapper.getCommentsByMemberNo(memberNo);
        return voList.stream().map(this::convertCommentToDto).collect(Collectors.toList());
    }
}
