package service;

import dto.BoardDTO;
import dto.PostAdminDTO;

import domain.TradeVO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

import java.util.Comparator;
import java.util.List;

@Service
public class AdminBoardService {

    private final BoardService boardService;
    private final TradeService tradeService;

    public AdminBoardService(BoardService boardService, TradeService tradeService) {
        this.boardService = boardService;
        this.tradeService = tradeService;
    }

    public List<PostAdminDTO> getAllPosts(int page, int pageSize) {
        int startRow = (page - 1) * pageSize;

        // 자유게시판 글 가져오기
        List<BoardDTO> boardList = boardService.getArticles(startRow, pageSize);

        // 중고거래 글 가져오기
        List<TradeVO> tradeList = tradeService.getPagedPosts(page, pageSize);

        List<PostAdminDTO> allPosts = new ArrayList<>();

        for (BoardDTO b : boardList) {
            PostAdminDTO dto = new PostAdminDTO();
            dto.setPostNo(b.getBoardno());
            dto.setTitle(b.getTitle());
            dto.setWriter(b.getMemberName());
            dto.setCreatedDate(b.getCreatedate());
            dto.setBoardType("자유게시판");
            dto.setStatus("게시됨");
            allPosts.add(dto);
        }

        for (TradeVO t : tradeList) {
            PostAdminDTO dto = new PostAdminDTO();
            dto.setPostNo(t.getTradePostNo());
            dto.setTitle(t.getTradeTitle());
            dto.setWriter(t.getMemberName());
            dto.setCreatedDate(t.getCreateDate());
            dto.setBoardType("중고거래");
            dto.setStatus(t.getStatus());
            allPosts.add(dto);
        }

        allPosts.sort(Comparator.comparing(PostAdminDTO::getCreatedDate).reversed());
        return allPosts;
    }


}
