package controller;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dao.SecondhandDAO;
import domain.SecondhandImageVO;
import domain.SecondhandVO;
import lombok.RequiredArgsConstructor;
import service.S3Service;

@Controller
public class SecondhandController {
	
	private final S3Service s3Service;
	public SecondhandController(S3Service s3service) {
		this.s3Service = s3service;
	}
	
	@GetMapping("/secondhandMain")
	public String shMainPage() {
		return "secondhandMain";
	}
	
	@GetMapping("/secondhandWrite")
	public String reviewWritePage() {
    	
		return "secondhandWrite";
    }
	
	@PostMapping("/secondhand/write")
	public String writeSecondhandArticle(SecondhandVO shArticle, @RequestParam("imageFile") MultipartFile file) {
		
		try {
			// 로그인 기능 없어서 임시로 '김철수'로 하드코딩
			shArticle.setMemberNo(4);
			shArticle.setCreateDate(new Timestamp(System.currentTimeMillis()));
			
			//img 파일을 S3에 업로드하여 URL 받기
			String imageUrl = s3Service.uploadFile(file);
			
			//img VO 생성
			SecondhandImageVO imageVO = new SecondhandImageVO();
			imageVO.setTradeImgUrl(imageUrl);
			
			// 글과 이미지 DB에 저장
			SecondhandDAO dao = SecondhandDAO.getInstance();
			dao.insertSHArticle(shArticle, imageVO);
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
        
        return "redirect:/secondhandMain";
	}
	
}
