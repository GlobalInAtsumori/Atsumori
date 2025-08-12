package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.annotations.Results;

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
			
			if(rs.next()) tradePostNo = rs.getInt(1)+1;
			else tradePostNo = 1;
			
			
			sql = "insert into tradePost(tradePostNo, tradeTitle, tradeContent, cost, "
					+ "status, createDate) "
					+ "values(tradepost_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, shArticle.getTradeTitle());
			pstmt.setString(2, shArticle.getTradeContent());
			pstmt.setInt(3, shArticle.getCost());
			pstmt.setString(4, shArticle.getStatus());
			pstmt.setTimestamp(5, shArticle.getCreateDate());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			try {
				if(rs!=null) rs.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
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
