package controller;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.SecondhandDAO;
import domain.SecondhandImageVO;
import domain.SecondhandVO;
import lombok.RequiredArgsConstructor;

@Controller
public class SecondhandController {
	
	@GetMapping("/secondhandMain")
	public String shMainPage() {
		return "secondhandMain";
	}
	
	@GetMapping("/secondhandWrite")
	public String reviewWritePage() {
    	
		return "secondhandWrite";
    }
	
	@PostMapping("/secondhand/write")
	public String writeSecondhandArticle(SecondhandVO shArticle, @RequestParam("imageUrl") String imageUrl) {
		// 로그인 기능 없어서 임시로 '김철수'로 하드코딩
        shArticle.setMemberNo(4);
        shArticle.setCreateDate(new Timestamp(System.currentTimeMillis()));
        
        //img VO 생성
        SecondhandImageVO imageVO = new SecondhandImageVO();
        imageVO.setTradeImgUrl(imageUrl);
        
        // DAO 호출
        SecondhandDAO dao = SecondhandDAO.getInstance();
        dao.insertSHArticle(shArticle, imageVO);
        
        return "redirect:/secondhandMain";
	}
	
}
