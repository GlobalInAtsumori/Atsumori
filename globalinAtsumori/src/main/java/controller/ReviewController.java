package controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import domain.ReviewVO;
import dto.ReviewCreateDTO;
import lombok.RequiredArgsConstructor;
import service.ReviewService;

@Controller
@RequiredArgsConstructor
public class ReviewController { //리뷰 등록/조회/수정/삭제
	private final ReviewService reviewService;
    
	@Value("${google.maps.api.key}")
    private String mapApiKey;
	
	@GetMapping("/reviewWrite")
	public String reviewWritePage(Model model) {
    	model.addAttribute("mapApiKey", mapApiKey);
    	
		return "reviewWrite";
    }
	
	@PostMapping("/review/create")
	public String createReview(ReviewCreateDTO reviewDto) throws IOException{ //추후 @SessionAttribute(name="userNo", required=false) int userNo 매개변수 추가
		int userNo = 2;
		
		reviewService.create(reviewDto, userNo);
		
		return "mainPage";
	}
	
	@GetMapping("/myReview")
	public String myReview(@RequestParam(defaultValue = "1") int page,
							@RequestParam(defaultValue = "5") int size,
							Model model) {
		int memberNo = 2;
		
		List<ReviewVO> list = reviewService.getMyReviewList(memberNo, page, size);
		model.addAttribute("list", list);
		
		return "";
	}
	
	@PostMapping("/review/update")
	public String updateReview() {
		return "mainPage";
	}
	
	@DeleteMapping("/review/delete/{no}")
	public String deleteReview(@PathVariable int no) {
		return "mainPage";
	}
}
