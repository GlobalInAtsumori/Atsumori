package controller;

import dto.BoardCommentDTO;
import dto.BoardDTO;
import service.MypageService; // MypageService를 import 합니다.
import service.BoardCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; 
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List; 
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private MypageService mypageService; // MypageService를 주입합니다.
    @Autowired
    private BoardCommentService boardCommentService; // 이 서비스도 계속 필요할 수 있으니 남겨둡니다.

    @GetMapping("/myPage_board")
    public String myPageBoard(HttpSession session, Model model) {
        // 실제 로그인 기능이 있다면 세션에서 현재 로그인된 사용자의 memberNo를 가져와야 합니다.
        // 현재는 memberNo를 1로 가정합니다.
        int memberNo = 1; 

        // MypageService를 통해 해당 사용자가 쓴 게시글 목록을 조회합니다.
        List<BoardDTO> myBoardList = mypageService.getArticlesByMemberNo(memberNo);

        // 조회된 목록을 myBoardList라는 이름으로 모델에 추가하여 JSP로 전달합니다.
        model.addAttribute("myBoardList", myBoardList);

        // myPage_board.jsp 페이지로 이동합니다.
        return "mypage/myPage_board";
    }

    @GetMapping("/myPage")
    public String myPage() {
        return "mypage/myPage";
    }
    
    @GetMapping("/myPage_boardComment")
    public String myPageBoardComment(HttpSession session, Model model) {
        int memberNo = 1; 
        // MypageService를 호출하도록 수정
        List<BoardCommentDTO> myCommentList = mypageService.getCommentsByMemberNo(memberNo);
        model.addAttribute("myCommentList", myCommentList);
        return "mypage/myPage_boardComment";
    }

    @GetMapping("/myPage_memberUpdate")
    public String myPageMemberUpdate() {
        return "mypage/myPage_memberUpdate";
    }
    
    @GetMapping("/myPage_restaurantReview")
    public String myPageRestaurantReview() {
        return "mypage/myPage_restaurantReview";
    }
    
    @GetMapping("/myPage_trade")
    public String myPageTrade() {
        return "mypage/myPage_trade";
    }
    
    @GetMapping("/myPage_followList")
    public String myPageFollowList() {
        return "mypage/myPage_followList";
    }
}