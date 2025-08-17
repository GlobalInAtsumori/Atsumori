package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
	
	public void insertSHArticle(SecondhandVO shArticle) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int tradePostNo = 0;
		
		try {
			
			con = DBConnect.getConnection();
			
			sql = "insert into tradePost(tradePostNo, tradeTitle, tradeContent, cost, "
					+ "status, memberNo, createDate) "
					+ "values(tradepost_seq.nextval, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, shArticle.getTradeTitle());
			pstmt.setString(2, shArticle.getTradeContent());
			pstmt.setInt(3, shArticle.getCost());
			//status null인 경우 기본값으로 AVAILABLE로 설정
			String status = shArticle.getStatus();
			if (status == null || status.trim().isEmpty()) {
			    status = "AVAILABLE";
			}
			pstmt.setString(4, status);
			pstmt.setInt(5, shArticle.getMemberNo());
			pstmt.setTimestamp(6, shArticle.getCreateDate());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			try {
				if(pstmt!=null) pstmt.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
			try {
				if(con!=null) con.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
			
		}
		
	}//end insertSHArticle
	
	
}
