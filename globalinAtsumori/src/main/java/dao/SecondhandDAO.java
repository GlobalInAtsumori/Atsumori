package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import domain.SecondhandImageVO;
import domain.SecondhandVO;

public class SecondhandDAO {
	private static SecondhandDAO instance = null;
	public SecondhandDAO() {
	}
	
	public static SecondhandDAO getInstance() {
		
		if(instance == null) {
			
			synchronized (SecondhandDAO.class) {
				instance = new SecondhandDAO();
			}
		}
		
		return instance;
		
	}
	
	public int insertSHArticle(SecondhandVO shArticle, SecondhandImageVO imageVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int tradePostNo = 0;
		
		try {
			
			con = DBConnect.getConnection();
			 con.setAutoCommit(false);
			
			//시퀀스 값 미리 받기
			String seqSql = "select tradepost_seq.NEXTVAL from dual";
			pstmt = con.prepareStatement(seqSql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				tradePostNo = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			
			//tradePost insert
			String postSql = "insert into tradePost(tradePostNo, tradeTitle, tradeContent, cost, "
					+ "status, memberNo, createDate) "
					+ "values(?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(postSql);
			pstmt.setInt(1, tradePostNo);
			pstmt.setString(2, shArticle.getTradeTitle());
			pstmt.setString(3, shArticle.getTradeContent());
			pstmt.setInt(4, shArticle.getCost());
			//status null인 경우 기본값으로 AVAILABLE로 설정
			String status = 
					(shArticle.getStatus() == null || shArticle.getStatus().trim().isEmpty()) 
                    ? "AVAILABLE" : shArticle.getStatus();
			pstmt.setString(5, status);
			pstmt.setInt(6, shArticle.getMemberNo());
			pstmt.setTimestamp(7, shArticle.getCreateDate());
			
			pstmt.executeUpdate();
			pstmt.close();
			
			//tradeImage insert
			String imgSql = "INSERT INTO tradeImage(tradeImgNo, tradeImgUrl, tradePostNo) "
					+ "VALUES(tradeimage_seq.NEXTVAL, ?, ?)";
			pstmt = con.prepareStatement(imgSql);
			pstmt.setString(1, imageVO.getTradeImgUrl());
			pstmt.setInt(2, tradePostNo);
			pstmt.executeUpdate();
			
			con.commit(); //모든 것이 성공하면
			
		} catch (Exception e) {
			try {
				if(con != null) con.rollback(); //실패한 게 있으면 롤백
			} catch (SQLException se) {
				se.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			
			try {if(rs != null) rs.close();} catch (SQLException se) {se.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch (SQLException se) {se.printStackTrace();}
			try {if(con!=null) con.close();} catch (SQLException se) {se.printStackTrace();}
			
		}
		return tradePostNo;
		
	}//end insertSHArticle
	
	public List<SecondhandVO> getSHListForMain() {
		List<SecondhandVO> list = new ArrayList<SecondhandVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = DBConnect.getConnection();
			
			String sql ="select p.tradePost, p.tradeTitle, p.cost, p.status, p.createDate, "
					+ "(select img.tradeImgUrl from tradeImgUrl img where img.tradePostNo = p.tradePost.No "
					+ "and ROWNUM = 1) as thumbnailUrl from tradePost p ORDER BY p.tradePostNo DESC";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SecondhandVO vo = new SecondhandVO();
				vo.setTradePostNo(rs.getInt("tradePostNo"));
				vo.setTradeTitle(rs.getString("tradeTitle"));
				vo.setCost(rs.getInt("cost"));
				vo.setStatus(rs.getString("status"));
				vo.setCreateDate(rs.getTimestamp("createDate"));
				vo.setThumbnailUrl(rs.getString("thumbnailUrl"));
				
				//status 값 AVAILABLE 판매중, 
				String status = rs.getString("status");
				if ("AVAILABLE".equalsIgnoreCase(status)) {
					vo.setStatusLabel("판매중");
				} else if ("TRADING".equalsIgnoreCase(status)) {
					vo.setStatusLabel("거래중");
				} else if ("DONE".equalsIgnoreCase(status)) {
					vo.setStatusLabel("판매완료");
				} else {
					vo.setStatusLabel("알수없음");
				}
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if (rs != null) rs.close();} catch (SQLException se) {se.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (SQLException se) {se.printStackTrace();}
			try {if (con != null) con.close();} catch (SQLException se) {se.printStackTrace();}
		}
		
		return list;
	} // end getSHListForMain
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
