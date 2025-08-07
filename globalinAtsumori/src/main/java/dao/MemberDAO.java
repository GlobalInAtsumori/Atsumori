package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import domain.MemberVO;
;

public class MemberDAO {

    private Connection conn;



	private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/your_database_name?serverTimezone=UTC",
            "your_username",
            "your_password"
        );
    }

    public void insertMember(MemberVO vo) {
        String sql = "INSERT INTO member (memberName, memberId, password, email, country) VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
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
    
    
    public int deleteMember(String memberId, String password) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 1. DB 연결 (Connection 얻기)
            conn = getConnection(); // 별도에 DB 연결 메서드 필요

            // 2. 입력한 비밀번호가 맞는지 확인
            String sqlCheck = "SELECT password FROM member WHERE memberId = ?";
            pstmt = conn.prepareStatement(sqlCheck);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password");
                if (dbPass.equals(password)) {
                    // 비밀번호 맞으면 삭제 실행
                    rs.close();
                    pstmt.close();

                    String sqlDelete = "DELETE FROM member WHERE memberId = ?";
                    pstmt = conn.prepareStatement(sqlDelete);
                    pstmt.setString(1, memberId);
                    int count = pstmt.executeUpdate();

                    if (count > 0) {
                        result = 1; // 성공
                    }
                } else {
                    // 비밀번호 불일치
                    result = 0;
                }
            } else {
                // 해당 아이디 없음
                result = 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            result = 0;
        } finally {
            // 자원 해제
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }
    
    
    
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

    
    
    public int updateMember(MemberVO vo) {
        int result = 0;

        String sql = "UPDATE member SET memberName = ?, password = ?, email = ?, country = ? WHERE memberId = ?";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
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

    
    
    public MemberVO getMember(String memberId) {
        MemberVO vo = null;
        Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

        String sql = "SELECT * FROM member WHERE memberId = ?";

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                vo = new MemberVO();
                vo.setMemberNo(rs.getInt("memberNo"));
                vo.setMemberId(rs.getString("memberId"));
                vo.setPassword(rs.getString("password"));
                vo.setMemberName(rs.getString("memberName"));
                vo.setEmail(rs.getString("email"));
                vo.setCountry(rs.getString("country"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }

        return vo;
    }

	private void close(Connection conn2, PreparedStatement pstmt, ResultSet rs) {
		// TODO Auto-generated method stub
		
	}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
