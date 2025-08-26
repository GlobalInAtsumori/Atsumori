package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import domain.TradeImageVO;
import domain.TradeVO;
import lombok.RequiredArgsConstructor;
import mapper.TradeImgMapper;
import mapper.TradeMapper;

@Service
@RequiredArgsConstructor
public class TradeService {
	
	private final TradeMapper tradeMapper;
	private final TradeImgMapper tradeImgMapper;
	//private final S3Service s3Service;
	
	//게시글(+이미지) 등록
	@Transactional
	public void writeTradePost(TradeVO tradeVO, TradeImageVO imageVO) {
		
		//1. 글 등록
		tradeMapper.insertTradePost(tradeVO);
		
		//2. tradePostNosms selectKey로 자동 세팅
		imageVO.setTradePostNo(tradeVO.getTradePostNo());
		
		//3. 이미지 등록
		tradeImgMapper.insertTradeImage(imageVO);
		
	}
	
	//메인페이지 출력용
	public List<TradeVO> getTradeList() {
		return tradeMapper.getTradeList();
	}
	
	//메인페이지 페이징
	public List<TradeVO> getPagedPosts(int page, int pageSize) {
		int totalPosts = tradeMapper.countPosts();
		int startRow = totalPosts - (page - 1) * pageSize - pageSize + 1;
		if (startRow < 1) startRow = 1;
		int endRow = totalPosts - (page - 1) * pageSize;
		
		List<TradeVO> posts = tradeMapper.selectPagedPosts(startRow, endRow);
		
		for (TradeVO post : posts) {
	        post.setRn(totalPosts - post.getRn() + 1); // rnDesc는 쿼리에서 부여한 역순 ROW_NUMBER
	    }
	    
	    return posts;
	}
	
	public int countPosts() {
		return tradeMapper.countPosts();
	}
	
	//상세 보기
	public TradeVO getPostDetail(int tradePostNo) {
		
		//글 정보
		TradeVO post = tradeMapper.getTradeDetail(tradePostNo);
		
		//이미지 정보
		List<TradeImageVO> image = tradeImgMapper.getTradeImage(tradePostNo);
		
		//글+이미지
		post.setImage(image);
		
		return post;
		
	}
	
	//거래희망(클릭시 거래중 등의 표기)
	public void updateStatusToTrading(int tradePostNo, String status) {
		tradeMapper.updateStatus(tradePostNo, status);
	}
	
}
