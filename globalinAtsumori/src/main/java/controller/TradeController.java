package controller;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import domain.TradeImageVO;
import domain.TradeVO;
import lombok.RequiredArgsConstructor;
import service.S3Service;

@Controller
public class TradeController {
	
	private final S3Service s3Service;
	public TradeController(S3Service s3service) {
		this.s3Service = s3service;
	}
	
	@GetMapping("/tradeMain")
	public String trMainPage() {
		return "tradeMain";
	}
	
	@GetMapping("/tradeWrite")
	public String reviewWritePage() {
    	
		return "tradeWrite";
    }
	
	@PostMapping("/trade/write")
	public String writeTradeArticle(TradeVO shArticle, @RequestParam("imageFile") MultipartFile file) {
		
		try {
			// 로그인 기능 없어서 임시로 '김철수'로 하드코딩
			shArticle.setMemberNo(4);
			shArticle.setCreateDate(new Timestamp(System.currentTimeMillis()));
			
			//img 파일을 S3에 업로드하여 URL 받기
			String imageUrl = s3Service.uploadFile(file);
			
			//img VO 생성
			TradeImageVO imageVO = new TradeImageVO();
			imageVO.setTradeImgUrl(imageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
        
        return "redirect:/tradeMain";
	}
	
}
