package dao;

import java.sql.*;
import java.util.*;


import org.mybatis.spring.SqlSessionTemplate;
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

    // 2️⃣ 회원가입 (member_seq 시퀀스 사용)
    public void insertMember(MemberVO vo) {
        String sql = "INSERT INTO member (memberNo, memberName, memberId, password, country, email) "
                   + "VALUES (member_seq.NEXTVAL, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vo.getMemberName());
            pstmt.setString(2, vo.getMemberId());
            pstmt.setString(3, vo.getPassword());
            pstmt.setString(4, vo.getCountry());
            pstmt.setString(5, vo.getEmail());

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
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
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

    // 5️⃣ 회원정보 수정
    public int updateMember(MemberVO vo) {
        int result = 0;
        String sql = "UPDATE member SET memberName=?, password=?, email=?, country=? WHERE memberId=?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, vo.getMemberName());
            pstmt.setString(2, vo.getPassword());
            pstmt.setString(3, vo.getEmail());
            pstmt.setString(4, vo.getCountry());
            pstmt.setString(5, vo.getMemberId());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // 6️⃣ 회원 삭제
    public boolean deleteMember(String memberId, String password) {
        int result = 0;
        String sqlCheck = "SELECT password FROM member WHERE memberId=?";
        String sqlDelete = "DELETE FROM member WHERE memberId=?";

        try (Connection conn = getConnection();
             PreparedStatement pstmtCheck = conn.prepareStatement(sqlCheck)) {

            pstmtCheck.setString(1, memberId);
            ResultSet rs = pstmtCheck.executeQuery();

            if (rs.next()) {
                String dbPass = rs.getString("password").trim(); // 공백 제거
                if (dbPass.equals(password)) { // 필요 시 equalsIgnoreCase 사용 가능
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


    // 7️⃣ 회원 정보 가져오기
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
                vo.setMemberId(rs.getString("memberId"));
                vo.setPassword(rs.getString("password"));
                vo.setMemberName(rs.getString("memberName"));
                vo.setEmail(rs.getString("email"));
                vo.setCountry(rs.getString("country"));
                vo.setPermission(rs.getString("permission")); // 🔑 권한 필드 추가
                System.out.println(rs.getString("permission"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vo;
    }
    
    
    @Autowired
    public List<MemberVO> getAllMembers() {
        List<MemberVO> list = new ArrayList<>();
        String sql = "SELECT * FROM member ORDER BY memberNo ASC";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while(rs.next()) {
                MemberVO vo = new MemberVO();
                vo.setMemberNo(rs.getInt("memberNo"));
                vo.setMemberId(rs.getString("memberId"));
                vo.setMemberName(rs.getString("memberName"));
                vo.setPassword(rs.getString("password"));
                vo.setEmail(rs.getString("email"));
                vo.setCountry(rs.getString("country"));
                vo.setPermission(rs.getString("permission"));
                list.add(vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("회원 수: " + list.size());
        return list;
    }


    // 3️⃣ 권한 변경
    public int updatePermission(int memberNo, String permission) {
        int result = 0;
        String sql = "UPDATE member SET permission=? WHERE memberNo=?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, permission);
            pstmt.setInt(2, memberNo);
            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


}
