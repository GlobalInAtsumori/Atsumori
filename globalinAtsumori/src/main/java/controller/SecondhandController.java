package controller;

import java.sql.Timestamp;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import dao.SecondhandDAO;
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
	public String writeSecondhandArticle(SecondhandVO shArticle, @RequestParam("imageFile") MultipartFile file) {
		// 로그인 기능 없어서 임시로 '김철수'로 하드코딩
        shArticle.setMemberNo(4);
        shArticle.setCreateDate(new Timestamp(System.currentTimeMillis()));

        // DAO를 통해 저장
        SecondhandDAO dao = SecondhandDAO.getInstance();
        int tradePostNo = dao.insertSHArticle(shArticle);
        
        if (file != null && !file.isEmpty()) {
            try {
                String imageUrl = s3Service.uploadFile(file);

                ReviewImageVO img = new ReviewImageVO();
                img.setReviewImgUrl(imageUrl);
                img.setReviewNo(tradePostNo);

                ReviewImageDAO imgDao = ReviewImageDAO.getInstance();
                imgDao.insert(img);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        return "redirect:/secondhandMain";
	}
	
}