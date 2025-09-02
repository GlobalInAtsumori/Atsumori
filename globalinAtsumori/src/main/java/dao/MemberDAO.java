package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.MemberVO;;

public class MemberDAO {

	private Connection conn;

	private Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		return DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:orcl",
				"scott", "tiger");
	}

	// 회원가입
	public void insertMember(MemberVO vo) {
		String sql = "INSERT INTO member (memberName, memberId, password, email, country) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, vo.getMemberName());
			pstmt.setString(2, vo.getMemberId());
			pstmt.setString(3, vo.getPassword());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getCountry());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 체크
	public int loginCheck(String memberId, String password) {
	    int result = -1; // -1: 아이디 없음, 0: 비밀번호 틀림, 1: 로그인 성공

	    String sql = "SELECT password FROM member WHERE memberId = ?";

	    try (
	        Connection conn = DBConnect.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	    ) {
	        pstmt.setString(1, memberId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String dbPassword = rs.getString("password");
	            if (dbPassword.equals(password)) {
	                result = 1; // 로그인 성공
	            } else {
	                result = 0; // 비밀번호 틀림
	            }
	        } else {
	            result = -1; // 아이디 없음
	        }

	        rs.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}


	// MemberDAO.java
	public boolean deleteMember(String memberId, String password) {
	    int result = 0;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = getConnection(); // DB 연결

	        // 1. 비밀번호 확인
	        String sqlCheck = "SELECT password FROM member WHERE memberId = ?";
	        pstmt = conn.prepareStatement(sqlCheck);
	        pstmt.setString(1, memberId);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String dbPass = rs.getString("password");
	            if (dbPass.equals(password)) {
	                // 비밀번호 맞으면 삭제
	                rs.close();
	                pstmt.close();

	                String sqlDelete = "DELETE FROM member WHERE memberId = ?";
	                pstmt = conn.prepareStatement(sqlDelete);
	                pstmt.setString(1, memberId);
	                int count = pstmt.executeUpdate();

	                if (count > 0) {
	                    result = 1; // 삭제 성공
	                }
	            } else {
	                result = 0; // 비밀번호 틀림
	            }
	        } else {
	            result = 0; // 아이디 없음
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        result = 0;
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return result == 1; // boolean 반환
	}




	    // ID 중복 체크
	    public boolean idCheck(String memberId) {
	        boolean exists = false;
	        String sql = "SELECT 1 FROM member WHERE memberId = ?";
	        try (Connection conn = DBConnect.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
	            pstmt.setString(1, memberId);
	            ResultSet rs = pstmt.executeQuery();
	            exists = rs.next();
	            rs.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return exists;
	    }

	
	//회원정보 수정
	public int updateMember(MemberVO vo) {
		int result = 0;

		String sql = "UPDATE member SET memberName = ?, password = ?, email = ?, country = ? WHERE memberId = ?";

		try (Connection conn = DBConnect.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, vo.getMemberName());
			pstmt.setString(2, vo.getPassword());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getCountry());
			pstmt.setString(5, vo.getMemberId());

			result = pstmt.executeUpdate(); // 1 이상이면 성공
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	
	
	public MemberVO getMember(String id) {
		MemberVO vo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs;
		
		try {
			conn = DBConnect.getConnection();
			String sql = "SELECT * FROM member WHERE memberId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new MemberVO();
				vo.setMemberId(rs.getString("memberId"));
				vo.setPassword(rs.getString("password"));
				vo.setMemberName(rs.getString("memberName"));
				vo.setEmail(rs.getString("email"));
				vo.setMemberNo(rs.getInt("memberNo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo; // 못 찾으면 null
	}

	private void close(Connection conn2, PreparedStatement pstmt, ResultSet rs) {
		// TODO Auto-generated method stub

	}

}
