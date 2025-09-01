package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import domain.BoardVO;
import domain.BoardCommentVO; // BoardCommentVO를 import합니다.

public interface MypageMapper {

	 //////////////////// 마이페이지 작성글 목록 메서드//////////
    List<BoardVO> getArticlesByMemberNo(@Param("memberNo") int memberNo);
    
    //////////////////// 마이페이지 댓글 목록 메서드//////////
    List<BoardCommentVO> getCommentsByMemberNo(@Param("memberNo") int memberNo);
	
	
}