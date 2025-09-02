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
import org.springframework.web.bind.annotation.SessionAttribute;

import dto.MyReviewDTO;
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
	public String createReview(ReviewCreateDTO reviewDto, @SessionAttribute(name="memberNo", required=false) Integer memberNo) throws IOException{
		if(memberNo == null) {
			//추가
		}else {
			reviewService.create(reviewDto, memberNo);
		}
		
		return "mainPage";
	}
	
//	@GetMapping("/myReview")
//	public String myReview(@SessionAttribute(name="memberNo", required=false) Integer memberNo,
//							@RequestParam(defaultValue = "1") int page,
//							@RequestParam(defaultValue = "5") int size,
//							Model model) {
//		
//		MyReviewDTO myReviewDTO = null;
//		
//		if(memberNo == null) {
//			//추가
//		}else {
//			myReviewDTO = reviewService.getMyReviewList(memberNo, page, size);
//		}
//		
//		model.addAttribute("myReviewDTO", myReviewDTO);
//		
//		return "";
//	}
	
	@PostMapping("/review/update/{reviewNo}")
	public String updateReview(@PathVariable int reviewNo) {
		
		return "mainPage";
	}
	
	@DeleteMapping("/review/delete/{reviewNo}")
	public String deleteReview(@PathVariable int reviewNo) {
		
		return "mainPage";
	}
}
