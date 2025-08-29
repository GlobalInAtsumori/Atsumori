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
	
	//게시글(+이미지) 수정
	@Transactional
	public void updateTradePost(TradeVO tradeVO) {
		//1. 현재 게시글 상태 확인(AVAILABLE일 때만 수정 가능)
		TradeVO statusCheck = tradeMapper.getTradeDetail(tradeVO.getTradePostNo());
		if(!"AVAILABLE".equals(statusCheck.getStatus())) {
			throw new IllegalStateException("取引中または販売完了の掲示物は修正不可能です。");
		}
		
		//2. (AVILABLE일 때) 게시글 수정
		tradeMapper.updateTradePost(tradeVO);
		
		//3. 이미지도 수정(재등록)하는 경우
		if(tradeVO.getImage() != null && !tradeVO.getImage().isEmpty()) {
			//기존 이미지 삭제
			tradeImgMapper.deleteTradeImage(tradeVO.getTradePostNo());
			//새로운 이미지 등록
			for (TradeImageVO imageVO : tradeVO.getImage()) {
				imageVO.setTradePostNo(tradeVO.getTradePostNo());
				tradeImgMapper.insertTradeImage(imageVO);
			}
		}
		
	}
	
	//게시글(+이미지) 삭제
	@Transactional
	public void deleteTradePost(int tradePostNo) {
		//status가 AVAILABLE일 때만 삭제 가능
		TradeVO post = tradeMapper.getTradeDetail(tradePostNo);
		if (!"AVAILABLE".equalsIgnoreCase(post.getStatus())) {
			throw new IllegalStateException("取引中または販売完了の掲示物は削除不可能です。");
		}
		
		//1. 이미지 삭제
		tradeImgMapper.deleteTradeImage(tradePostNo);
		
		//2. 게시글 삭제
		tradeMapper.deleteTradePost(tradePostNo);
	}
	
	//메인페이지 페이징(검색 없음)
	public List<TradeVO> getPagedPosts(int page, int pageSize) {
		int totalPosts = tradeMapper.countPosts();
		
		int startRow = totalPosts - (page - 1) * pageSize - pageSize + 1;
		if (startRow < 1) startRow = 1;
		int endRow = totalPosts - (page - 1) * pageSize;
		
		List<TradeVO> posts = tradeMapper.selectPagedPosts(startRow, endRow);
		
		for (TradeVO post : posts) {
			post.setRn(post.getRn());
		}
		
		return posts;
	}
	
	//메인페이지 페이징(검색 있음)
	public List<TradeVO> getPagedPosts(int page, int pageSize, String keyword, String type) {
		int totalPosts = (keyword == null || keyword.isEmpty()) ?
		        tradeMapper.countPosts() :
		            tradeMapper.countPostsByKeyword(keyword, type);
		int startRow = totalPosts - (page - 1) * pageSize - pageSize + 1;
		if (startRow < 1) startRow = 1;
		int endRow = totalPosts - (page - 1) * pageSize;
	    
		if(keyword == null || keyword.isEmpty()) {
	        return tradeMapper.selectPagedPosts(startRow, endRow);
	    } else {
	        return tradeMapper.selectPagedPostsByKeyword(startRow, endRow, keyword, type);
	    }
	}
	
	//총개수
	public int countPosts() {
		return tradeMapper.countPosts();
	}
	
	//검색용 글 개수
	public int countPostsByKeyword(String keyword, String type) {
		if(keyword == null || keyword.isEmpty()) {
			return tradeMapper.countPosts();
		}
		return tradeMapper.countPostsByKeyword(keyword, type);
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
