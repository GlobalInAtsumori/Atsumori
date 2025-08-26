package controller;

import dto.BoardCommentDTO;
import dto.BoardDTO;
import service.BoardCommentService;
import service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;
    @Autowired
    private BoardCommentService boardCommentService; // 댓글 부분을 추가

    @GetMapping("/list.do")
    public String getArticleList(@RequestParam(defaultValue = "1") int pageNum,
                                 @RequestParam(required = false) String searchWhat,
                                 @RequestParam(required = false) String searchText,
                                 Model model) {
        int pageSize = 5;
        int currentPage = pageNum;
        int startRow = (currentPage - 1) * pageSize + 1;

        int count;
        List<BoardDTO> articleList;

        if (searchWhat != null && !searchWhat.isEmpty() && searchText != null && !searchText.isEmpty()) {
            count = boardService.getArticleCountBySearch(searchWhat, searchText);
            articleList = boardService.getArticles(searchWhat, searchText, startRow, pageSize);
        } else {
            count = boardService.getArticleCount();
            articleList = boardService.getArticles(startRow, pageSize);
        }

        int number = count - (currentPage - 1) * pageSize;

        model.addAttribute("count", count);
        model.addAttribute("articleList", articleList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("number", number);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("searchWhat", searchWhat != null ? searchWhat : "");
        model.addAttribute("searchText", searchText != null ? searchText : "");

        return "board/list";
    }

    @GetMapping("/content.do")
    public String getContent(@RequestParam int boardno,
                             @RequestParam String pageNum,
                             Model model) {
        BoardDTO article = boardService.getArticle(boardno);
        List<BoardCommentDTO> commentList = boardCommentService.getCommentsByBoardNo(boardno); // 이 부분을 추가

        model.addAttribute("article", article);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("commentList", commentList); // 이 부분을 추가

        return "board/content";
    }

    @GetMapping("/writeForm.do")
    public String writeForm() {
        return "board/writeForm";
    }

    @PostMapping("/writeProc.do")
    public String writeArticle(@ModelAttribute BoardDTO article, HttpSession session) {
        // 실제 로그인 기능이 있다면 세션에서 memberNo를 가져와야 합니다.
        // 현재는 memberNo 1번으로 고정하여 테스트합니다.
        // 이 부분은 실제 로그인 구현 시 수정이 필요합니다.
        article.setMemberno(1);
        boardService.insertArticle(article);
        return "redirect:/board/list.do";
    }

    @GetMapping("/updateForm.do")
    public String updateForm(@RequestParam int boardno, @RequestParam String pageNum, Model model) {
        BoardDTO article = boardService.getArticle(boardno);
        model.addAttribute("article", article);
        model.addAttribute("pageNum", pageNum);
        return "board/updateForm";
    }

    @PostMapping("/updateProc.do")
    public String updateArticle(@ModelAttribute BoardDTO updateDTO, @RequestParam int boardno, @RequestParam int pageNum) {
        // 폼에서 넘어온 boardno를 DTO에 수동으로 설정
        updateDTO.setBoardno(boardno);
        boardService.updateArticle(updateDTO);
        return "redirect:/board/list.do?pageNum=" + pageNum;
    }

    @GetMapping("/deleteForm.do")
    public String deleteForm(@RequestParam int boardno, @RequestParam String pageNum, Model model) {
        model.addAttribute("boardno", boardno);
        model.addAttribute("pageNum", pageNum);
        return "board/deleteForm";
    }

    @PostMapping("/deleteProc.do")
    public String deleteArticle(@RequestParam int boardno, @RequestParam String pageNum, RedirectAttributes redirectAttrs) {
        int check = boardService.deleteArticle(boardno);
        if (check == 1) {
            return "redirect:/board/list.do?pageNum=" + pageNum;
        } else {
            redirectAttrs.addFlashAttribute("msg", "삭제에 실패했습니다.");
            return "redirect:/board/deleteForm.do?boardno=" + boardno + "&pageNum=" + pageNum;
        }
    }
}