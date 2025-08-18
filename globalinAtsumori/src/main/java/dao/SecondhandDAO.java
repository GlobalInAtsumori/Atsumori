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
	
	public List<SecondhandVO> getSHListForMain(int start, int end) {
		List<SecondhandVO> list = new ArrayList<SecondhandVO>();
		String sql = "select tp.tradePostNo, tp, tradeTitle, tp.cost, tp.status, tp.createDate, "
				+ "(select ti.tradeImgUrl from tradeImage ti where ti.tradePostNo = tp.tradePostNo "
				+ "and ROWNUM = 1) as thumbnail "
				+ "from tradePost tp order by tp.tradePostNo DESC "
				+ "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		
		try (Connection con = DBConnect.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			try (ResultSet rs = pstmt.executeQuery()) {
				
				while(rs.next()) {
					SecondhandVO vo = new SecondhandVO();
					vo.setTradePostNo(rs.getInt("tradePostNo"));
					vo.setTradeTitle(rs.getString("tradeTitle"));
					vo.setCost(rs.getInt("cost"));
					//거래 상태에 대한 것
					String status = rs.getString("status");
					vo.setStatus("AVAILABLE".equals(status) ? "판매중" : status);
					vo.setCreateDate(rs.getTimestamp("createDate"));
					//vo에 썸네일 필드 만들고 연동시켜야 함.. 
					
					list.add(vo);
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	} // end getSHListForMain
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
