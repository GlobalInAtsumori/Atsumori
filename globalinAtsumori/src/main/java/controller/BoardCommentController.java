package controller;

import dto.BoardCommentDTO;
import service.BoardCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardCommentController {

    @Autowired
    private BoardCommentService boardCommentService;

    // 댓글 작성 요청 처리
    @PostMapping("/addComment")
    public String addComment(@ModelAttribute BoardCommentDTO commentDto, 
                             @RequestParam String pageNum, // pageNum 파라미터를 추가
                             HttpSession session, 
                             RedirectAttributes redirectAttrs) {
        // 실제 로그인 기능이 있다면 세션에서 memberNo를 가져와야 합니다.
        // 현재는 memberNo 1번으로 고정하여 테스트합니다.
        Integer memberNo = (Integer) session.getAttribute("memberNo");
        if (memberNo == null) {
            commentDto.setMemberNo(1);
        } else {
            commentDto.setMemberNo(memberNo);
        }
        
        boardCommentService.addComment(commentDto);
        
        // 리다이렉션 시 필요한 파라미터들을 모두 추가
        redirectAttrs.addAttribute("boardno", commentDto.getBoardNo());
        redirectAttrs.addAttribute("pageNum", pageNum); 
        
        return "redirect:/board/content";
    }

    // 댓글 삭제 요청 처리
    @PostMapping("/deleteComment")
    public String deleteComment(@RequestParam int commentNo, 
                                @RequestParam int boardNo, 
                                @RequestParam String pageNum, 
                                RedirectAttributes redirectAttrs) {
        int check = boardCommentService.deleteComment(commentNo);
        if (check == 1) {
            redirectAttrs.addFlashAttribute("msg", "댓글이 삭제되었습니다.");
        } else {
            redirectAttrs.addFlashAttribute("msg", "댓글 삭제에 실패했습니다.");
        }
        redirectAttrs.addAttribute("boardno", boardNo);
        redirectAttrs.addAttribute("pageNum", pageNum);
        return "redirect:/board/content";
    }
}