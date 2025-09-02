package controller;

import java.util.ArrayList;
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
							@RequestParam(required = false) String keyword, //검색 키워드
							@RequestParam(defaultValue = "title") String type, //검색 대상(title, content, member)
							Model model) {
		
		//총 게시물 수
		int total = (keyword == null || keyword.isEmpty()) ? 
				tradeService.countPosts() : 
				tradeService.countPostsByKeyword(keyword, type);
		
		//총 페이지 수(게시글 없을 때도 1페이지)
		int totalPages = (int) Math.ceil(total / (double)pageSize);
		if (totalPages == 0) totalPages = 1;
		
		//page의 범위
		if(page < 1) page = 1;
		if(page > totalPages) page = totalPages;
		
		//현재 페이지 목록
		List<TradeVO> tradeList = (keyword == null || keyword.isEmpty()) ? 
				tradeService.getPagedPosts(page, pageSize) : 
				tradeService.getPagedPosts(page, pageSize, keyword, type);
		
		//페이지 블록
		int blockSize = 3;
		int currentBlock = (int) Math.ceil((double) page / blockSize);
		int startPage = (currentBlock - 1) * blockSize + 1;
		int endPage = Math.min(currentBlock * blockSize, totalPages);
		
		
		//jsp 용
		model.addAttribute("tradeList", tradeList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("keyword", keyword);
		model.addAttribute("type", type);
		
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
	
	//글 수정 (원본 데이터 화면)
	@GetMapping("/tradeUpdate")
	public String tradeUpdate(@RequestParam("tradePostNo") int tradePostNo, 
								Model model, RedirectAttributes ra) {
		TradeVO post = tradeService.getPostDetail(tradePostNo);
		
		//status 체크
		if(!"AVAILABLE".equals(post.getStatus())) {
			ra.addFlashAttribute("errorMsg", "取引中または販売完了の掲示物は修正不可能です。");
			return "redirect:/tradeDetail?tradePostNo="+tradePostNo;
		}
		
		model.addAttribute("post", post);
		return "tradeUpdate";
	}
	
	//글 수정 (수정 처리)
	@PostMapping("/trade/update")
	public String updateTradePost(TradeVO tradeVO, 
			@RequestParam(value = "imageFile", required = false) MultipartFile file, 
			RedirectAttributes ra) {
		
		try {
			//status 체크
			TradeVO current = tradeService.getPostDetail(tradeVO.getTradePostNo());
			if(!"AVAILABLE".equals(current.getStatus())) {
				throw new IllegalStateException("取引中または販売完了の掲示物は修正不可能です。");
			}
			
			//이미지를 새로 등록한 경우 교체
			if(file != null && !file.isEmpty()) {
				String imgUrl = s3Service.uploadFile(file);
				TradeImageVO imageVO = new TradeImageVO();
				imageVO.setTradeImgUrl(imgUrl);
				
				List<TradeImageVO> image = new ArrayList<TradeImageVO>();
				image.add(imageVO);
				tradeVO.setImage(image);
			}
			
			tradeService.updateTradePost(tradeVO);
			
			ra.addFlashAttribute("msg", "修正しました。");
			return "redirect:/tradeDetail?tradePostNo="+tradeVO.getTradePostNo();
			
		} catch (IllegalStateException ise) {
			ra.addFlashAttribute("errorMsg", ise.getMessage());
			return "redirect:/tradeDetail?tradePostNo="+tradeVO.getTradePostNo();			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	//글 삭제
	@PostMapping("/trade/delete")
	public String deleteTradePost(@RequestParam("tradePostNo") int tradePostNo,
									RedirectAttributes ra) {
		try {
			tradeService.deleteTradePost(tradePostNo);
			ra.addFlashAttribute("msg", "削除しました。");
			return "redirect:/tradeMain";
		} catch (IllegalStateException e) {
			ra.addFlashAttribute("errorMsg", e.getMessage());
			return "redirect:/tradeDetail?tradePostNo=" + tradePostNo;
		}
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
