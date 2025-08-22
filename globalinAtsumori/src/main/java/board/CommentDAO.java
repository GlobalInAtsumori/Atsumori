package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//CommentDAO 클래스는 게시판 데이터를 DB에 저장하고 불러오는 기능을 담당.
public class CommentDAO {

	//프로그램 전체에서 CommentDAO 객체는 하나만 만들어서 사용하도록 함
	private static CommentDAO instance = null;
	
	//생성자를 private로 만들어 외부에서 객체 생성 못하게 함
	private CommentDAO() {}
	
	//CommentDAO 객체를 가져오는 메소드
	public static CommentDAO getInstance() {
		if(instance == null) {
			synchronized (CommentDAO.class) { //동시에 여러 스레드가 접근해도 안전하게 하나만 생성
				instance = new CommentDAO();
			}
		}
		
		return instance;
	}
	
	//=========글 추가============
	/*
	 * insertArticle(CommentVO article)
	 * CommentVO 객체(article)에 저장된 정보를 데이터베이스에 저장
	 */
	public void insertArticle(CommentVO article) {
		Connection con = null;	//데이터베이스 연결 객체
		PreparedStatement pstmt = null;	//SQL 실행 객체
		ResultSet rs = null;	//조회 결과 저장 객체
		
		// 정보를 가져옴
		int commentno = article.getCommentno();
		String content = article.getContent();
		Date createdate = article.getCreatedate();
		int boardno = article.getBoardno();
		int userno = article.getUserno();
		
		int commentnumber = 0;
		
		String sql = "";
		
		try {
			con = ConnUtil.getConnection();
			pstmt = con.prepareStatement("select max(num) from boardComment"); //현재 글 중 가장 큰 번호 조회
			rs = pstmt.executeQuery();
			
			//새글일 경우 글 번호 결정
			if(rs.next()) commentnumber = rs.getInt(1) + 1;
			else commentnumber = 1;
			
			//댓글 정보를 DB에 삽입
			sql = "insert into boardComment(commentno, content, createdate, boardno, userno) "
					+ "values(boardcomment_seq.nextval, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, article.getCommentno());
			pstmt.setString(2, article.getContent());
			pstmt.setDate(3, article.getCreatedate());
			pstmt.setInt(4, article.getBoardno());
			pstmt.setInt(5, article.getUserno());
			
			pstmt.executeUpdate();		//DB에 실제 반영
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			
			//사용한 DB 리소스 닫기
			try {
				if (con != null)
					con.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			
		}
	}	//public void insertArticle(CommentVO article)의 끝
	
	
	/*
	//=========전체 댓글 개수 가져오기=============
	//	getArticleCount()
	//	-데이터베이스에 저장된 전체 댓글의 수를 반환
	
	public int getArticleCOunt() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0; // 전체 댓글 개수 저장 변수
		
		try {
			con = ConnUtil.getConnection();
			String sql = "select count(*) from board2"; //댓글 개수 조회
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(x);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			
			try {
				if (con != null)
					con.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
		}
		
		return x;
	}
	*/
	
	
	//==============댓글 내용 보기=====================
	/*
	 * 		getArticle(int num)
	 * 		-글 번호(num)에 해당하는 글 하나의 정보를 가져옴
	 * 		-조회수(readcount) 증가
	 */
	
	public CommentVO getArticle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommentVO article = null;
		
		try {
			con = ConnUtil.getConnection();
			String sql = "select * from boardComment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new CommentVO();
				article.setCommentno(rs.getInt("num"));
				article.setContent(rs.getString("content"));
				article.setCreatedate(rs.getDate("createdate"));
				article.setBoardno(rs.getInt("boardno"));
				article.setUserno(rs.getInt("userno"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			
			try {
				if (con != null)
					con.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
				
				return article;
		}
			
			
	} //public CommentVO getArticle(int num)의 끝
	
	
	//==================글 삭제=======================
	/*
	 * 		deleteArticle(int num, String pass)
	 * 		-글 삭제 시 비밀번호 확인 후 삭제
	 * 		-성공: 1, 비밀번호 불일치: 0, 오류: -1
	 */
	
	public int deleteArticle(int num, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int result = -1;
		
		try {
			con = ConnUtil.getConnection();
			pstmt = con.prepareStatement("select pass from boardComment where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("pass");
				if(dbpasswd.equals(pass)) {
					sql = "delete from boardComment where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1;	//삭제 성공
				} else {
					result = 0; //비밀번호 불일치
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			
			try {
				if (con != null)
					con.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException ss) {
				ss.printStackTrace();
			}
			
			
		}
		
		return result;
	}
		
		
		
	
	
}
