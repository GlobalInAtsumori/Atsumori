package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MembercheckDAO {

	private Connection getConnection() throws Exception {
        // 예시: JDBC 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC";
        String user = "db_user";
        String password = "db_password";
        return DriverManager.getConnection(url, user, password);
    }

    // ID 중복 체크 메서드
    public boolean idCheck(String id) {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            String sql = "SELECT memberId FROM member WHERE memberId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 아이디가 이미 존재하면 true 반환
                exists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return exists;
    }
}
