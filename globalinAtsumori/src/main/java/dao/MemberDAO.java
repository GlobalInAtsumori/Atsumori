package dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import domain.MemberVO;

public class MemberDAO {

    // 1️⃣ DB 연결
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:orcl", 
                "scott", 
                "tiger");
    }

    // 2️⃣ 회원가입
    public void insertMember(MemberVO vo) {
        String sql = "INSERT INTO member (memberNo, memberName, memberId, password, country, email, permission) "
                   + "VALUES (member_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vo.getMemberName());
            pstmt.setString(2, vo.getMemberId());
            pstmt.setString(3, vo.getPassword());
            pstmt.setString(4, vo.getCountry());
            pstmt.setString(5, vo.getEmail());
            
            // 🔑 permission null이면 기본값 'user'
            String perm = vo.getPermission();
            if(perm == null || perm.isEmpty()) perm = "user";
            pstmt.setString(6, perm);

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3️⃣ ID 중복 체크
    public boolean idCheck(String memberId) {
        String sql = "SELECT COUNT(*) FROM member WHERE memberId = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4️⃣ 로그인 체크
    public int loginCheck(String memberId, String password) {
        int result = -1;
        String sql = "SELECT password FROM member WHERE memberId = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                result = dbPassword.equals(password) ? 1 : 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 5️⃣ 회원 정보 가져오기
    public MemberVO getMember(String memberId) {
        MemberVO vo = null;
        String sql = "SELECT * FROM member WHERE memberId=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                vo = new MemberVO();
                vo.setMemberNo(rs.getInt("memberNo"));
                vo.setMemberName(rs.getString("memberName"));
                vo.setMemberId(rs.getString("memberId"));
                vo.setPassword(rs.getString("password"));
                vo.setCountry(rs.getString("country"));
                vo.setEmail(rs.getString("email"));
                vo.setPermission(rs.getString("permission"));
                vo.setSanctionStatus(rs.getString("sanction_status")); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return vo;
    }

    // 6️⃣ 회원정보 수정
    public int updateMember(MemberVO vo) {
        int result = 0;
        String sql = "UPDATE member SET memberName=?, password=?, country=?, email=? WHERE memberId=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vo.getMemberName());
            pstmt.setString(2, vo.getPassword());
            pstmt.setString(3, vo.getCountry());
            pstmt.setString(4, vo.getEmail());
            pstmt.setString(5, vo.getMemberId());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 7️⃣ 회원 삭제
    public boolean deleteMember(String memberId, String password) {
        int result = 0;
        String sqlCheck = "SELECT password FROM member WHERE memberId=?";
        String sqlDelete = "DELETE FROM member WHERE memberId=?";

        try (Connection conn = getConnection();
             PreparedStatement pstmtCheck = conn.prepareStatement(sqlCheck)) {

            pstmtCheck.setString(1, memberId);
            ResultSet rs = pstmtCheck.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password").trim();
                if (dbPass.equals(password)) {
                    rs.close();
                    try (PreparedStatement pstmtDelete = conn.prepareStatement(sqlDelete)) {
                        pstmtDelete.setString(1, memberId);
                        result = pstmtDelete.executeUpdate();
                    }
                }
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result > 0;
    }

    
    // 회원 전체 조회
    public List<MemberVO> getAllMembers() {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM member ORDER BY memberNo ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

        	while(rs.next()) {
        	    MemberVO vo = new MemberVO();
        	    vo.setMemberNo(rs.getInt("MEMBERNO"));       // memberNo -> MEMBERNO
        	    vo.setMemberName(rs.getString("MEMBERNAME")); // memberName -> MEMBERNAME
        	    vo.setMemberId(rs.getString("MEMBERID"));    // memberId -> MEMBERID
        	    vo.setPassword(rs.getString("PASSWORD"));    // password -> PASSWORD
        	    vo.setCountry(rs.getString("COUNTRY"));      // country -> COUNTRY
        	    vo.setEmail(rs.getString("EMAIL"));          // email -> EMAIL
        	    vo.setPermission(rs.getString("PERMISSION")); // permission -> PERMISSION
        	    list.add(vo);
        	}
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    
 // MemberDAO.java 안에 추가
    public List<MemberVO> getMembersByPage(int page, int pageSize) {
        List<MemberVO> list = new ArrayList<>();
        
        // 시작 번호와 끝 번호 계산
        int start = (page - 1) * pageSize + 1;
        int end = page * pageSize;
        
        // Oracle ROWNUM 활용한 페이징 쿼리
        String sql = "SELECT * FROM (" +
                     "    SELECT a.*, ROWNUM rnum FROM (" +
                     "        SELECT * FROM member ORDER BY memberNo ASC" +
                     "    ) a WHERE ROWNUM <= ?" +
                     ") WHERE rnum >= ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, end);
            pstmt.setInt(2, start);

            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setMemberNo(rs.getInt("MEMBERNO"));
                    vo.setMemberName(rs.getString("MEMBERNAME"));
                    vo.setMemberId(rs.getString("MEMBERID"));
                    vo.setPassword(rs.getString("PASSWORD"));
                    vo.setCountry(rs.getString("COUNTRY"));
                    vo.setEmail(rs.getString("EMAIL"));
                    vo.setPermission(rs.getString("PERMISSION"));
                    list.add(vo);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
 // MemberDAO.java
    public int getTotalCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM member";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }


    
    
    // 권한 변경
    public void updatePermission(int memberNo, String permission) {
        if(permission == null || permission.trim().isEmpty()) {
            permission = "user"; // 기본값 설정
        }
        String sql = "UPDATE member SET permission=? WHERE memberNo=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, permission);
            pstmt.setInt(2, memberNo);
            pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    
    
    
    
	/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>검색기능<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
 // 이름으로 검색
    public List<MemberVO> getMembersByName(String name) {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM member WHERE memberName LIKE ? ORDER BY memberNo ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + name + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setMemberNo(rs.getInt("MEMBERNO"));
                    vo.setMemberName(rs.getString("MEMBERNAME"));
                    vo.setMemberId(rs.getString("MEMBERID"));
                    vo.setPassword(rs.getString("PASSWORD"));
                    vo.setCountry(rs.getString("COUNTRY"));
                    vo.setEmail(rs.getString("EMAIL"));
                    vo.setPermission(rs.getString("PERMISSION"));
                    list.add(vo);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ID로 검색
    public List<MemberVO> getMembersById(String id) {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM member WHERE memberId LIKE ? ORDER BY memberNo ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + id + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setMemberNo(rs.getInt("MEMBERNO"));
                    vo.setMemberName(rs.getString("MEMBERNAME"));
                    vo.setMemberId(rs.getString("MEMBERID"));
                    vo.setPassword(rs.getString("PASSWORD"));
                    vo.setCountry(rs.getString("COUNTRY"));
                    vo.setEmail(rs.getString("EMAIL"));
                    vo.setPermission(rs.getString("PERMISSION"));
                    list.add(vo);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 권한으로 검색
    public List<MemberVO> getMembersByPermission(String permission) {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM member WHERE permission = ? ORDER BY memberNo ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, permission);
            try (ResultSet rs = pstmt.executeQuery()) {
                while(rs.next()) {
                    MemberVO vo = new MemberVO();
                    vo.setMemberNo(rs.getInt("MEMBERNO"));
                    vo.setMemberName(rs.getString("MEMBERNAME"));
                    vo.setMemberId(rs.getString("MEMBERID"));
                    vo.setPassword(rs.getString("PASSWORD"));
                    vo.setCountry(rs.getString("COUNTRY"));
                    vo.setEmail(rs.getString("EMAIL"));
                    vo.setPermission(rs.getString("PERMISSION"));
                    list.add(vo);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
 // 회원번호로 회원 삭제
    public int deleteMemberByNo(int memberNo) {
        int result = 0;
        Connection conn = null;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 연관 테이블 먼저 삭제
            try (PreparedStatement pstmt1 = conn.prepareStatement(
                    "DELETE FROM comment WHERE memberNo = ?")) {
                pstmt1.setInt(1, memberNo);
                pstmt1.executeUpdate();
            }

            try (PreparedStatement pstmt2 = conn.prepareStatement(
                    "DELETE FROM board WHERE memberNo = ?")) {
                pstmt2.setInt(1, memberNo);
                pstmt2.executeUpdate();
            }

            // 마지막으로 member 삭제
            try (PreparedStatement pstmt3 = conn.prepareStatement(
                    "DELETE FROM member WHERE memberNo = ?")) {
                pstmt3.setInt(1, memberNo);
                pstmt3.executeUpdate();
            }

            conn.commit(); // 트랜잭션 커밋
            result = 1;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // 롤백
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) conn.close(); // 연결 종료
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return result;
    }



    



    /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>검색기능<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

    public int updateSanction(int memberNo, String status) {
        int result = 0;
        String sql = "UPDATE member SET sanctionStatus = ? WHERE memberNo = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, memberNo);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteMemberCompletely(int memberNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0; // 삭제된 회원 수

        try {
            conn = getConnection();

            // (삭제 순서는 그대로)
            pstmt = conn.prepareStatement("DELETE FROM boardComment WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM board2 WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM reviewImage WHERE reviewNo IN (SELECT reviewNo FROM review WHERE memberNo = ?)");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM review WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM tradeImage WHERE tradePostNo IN (SELECT tradePostNo FROM tradePost WHERE memberNo = ?)");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM chatMessage WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = conn.prepareStatement("DELETE FROM tradePost WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            pstmt.executeUpdate();
            pstmt.close();

            // 최종 member 삭제
            pstmt = conn.prepareStatement("DELETE FROM member WHERE memberNo = ?");
            pstmt.setInt(1, memberNo);
            result = pstmt.executeUpdate(); // 삭제된 회원 수 반환
            pstmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return result;
    }


    
}
