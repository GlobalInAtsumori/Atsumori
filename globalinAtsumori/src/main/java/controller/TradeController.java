package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import domain.TradeImageVO;
import domain.TradeVO;
import lombok.RequiredArgsConstructor;
//import service.ReviewService;
import service.S3Service;
import service.TradeService;

@Controller
@RequiredArgsConstructor
public class TradeController {
	
	private final S3Service s3Service;
	private final TradeService tradeService;
	/*
	public TradeController(S3Service s3service) {
		this.s3Service = s3service;
	}
	*/
	
	//메인 페이지
	//글 목록 출력
	@GetMapping("/tradeMain")
	public String trMainPage(@RequestParam(defaultValue = "1") int page,
							@RequestParam(defaultValue = "6") int pageSize, //6개씩 출력
							Model model) {
		
		//총 게시물 수
		int total = tradeService.countPosts();
		
		//현재 페이지의 게시글 목록
		List<TradeVO> tradeList = tradeService.getPagedPosts(page, pageSize);
		
		//총 페이지 수 계산
		int totalPages = (int)Math.ceil((double) total / pageSize );
		
		//jsp 용
		model.addAttribute("tradeList", tradeList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", total);
		
		return "tradeMain";
	}
	
	//글쓰기
	@GetMapping("/tradeWrite")
	public String reviewWritePage() {
    	
		return "tradeWrite";
    }
	
	//글 등록
	@PostMapping("/trade/write")
	public String writeTradeArticle(TradeVO trArticle, 
									@RequestParam("imageFile") MultipartFile file) {
		
		try {
			//로그인 기능 없어서 임시로 하드코딩
			trArticle.setMemberNo(4);
			
			//img 파일을 S3에 업로드하여 URL 받기
			String imageUrl = s3Service.uploadFile(file);
			
			//img VO 생성
			TradeImageVO imageVO = new TradeImageVO();
			imageVO.setTradeImgUrl(imageUrl);
			
			//service로 글+이미지 등록
			tradeService.writeTradePost(trArticle, imageVO);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
        
        return "redirect:/tradeMain";
	}
	
	//상세페이지
	@GetMapping("/tradeDetail")
	public String tradeDetail( @RequestParam("tradePostNo") int tradePostNo, Model model ) {
		TradeVO post = tradeService.getPostDetail(tradePostNo);
		model.addAttribute("post", post);
		return "tradeDetail";
	}
	
	//거래희망 누를 경우
	@PostMapping("/updateStatus")
	public String updateStatus(@RequestParam int tradePostNo, 
								@RequestParam String status,
								RedirectAttributes redirectAttributes) {
		tradeService.updateStatusToTrading(tradePostNo, status);
		//상세페이지로 리다이렉트
		redirectAttributes.addAttribute("tradePostNo", tradePostNo);
		return "redirect:/tradeDetail";
	}
	
	
}
