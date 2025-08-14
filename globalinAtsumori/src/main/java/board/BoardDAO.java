package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

public class BoardDAO {
	private static BoardDAO instance =null;
	
	private BoardDAO() {}
	
		
		public static BoardDAO getInstance() {
			
			if (instance == null) {
				synchronized (BoardDAO.class) {
					instance = new BoardDAO();
				}
			}
			return instance;
		}
		
		// 여기서부터 게시판에 작업할 기능을 하나씩 메소드로 구현하여 추가하면 됨
		
		/*
		 * 실제 데이터베이스에 데이터를 저장할 메소드를 구현
		 * insertArticle(BoardVO article)
		 */	
		
		public void insertArticle(BoardVO article) {
			Connection con = null;
			// 조회를 위해, 무엇이 들어갈지 모르는 경우
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int num = article.getNum();
			int ref = article.getRef();
			int step = article.getStep();
			int depth = article.getDepth();
			
			int number = 0;
			
			String sql = "";
			
			try {
				con = ConnUtil.getConnection();
				pstmt = con.prepareStatement("select max(num) from board");
				rs= pstmt.executeQuery();
				
				// 새글일 때
				if(rs.next()) number = rs.getInt(1)+1;
				else number = 1;
				
				// 답변글 (댓글일 경우)
				if(num!=0) {
					sql = "update board set step = step+1 where ref=? and step >?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.setInt(2, step);
					pstmt.executeUpdate();
					step = step + 1;
					depth = depth + 1;
					
				} else {
					ref = number;
					step = 0;
					depth = 0;
				}
				
				sql = "insert into board(num, writer, email, subject, pass, regdate, "
						+ "ref, step, depth, content, ip) "
						+ "values(board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ? , ? )";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getEmail());
				pstmt.setString(3, article.getSubject());
				pstmt.setString(4, article.getPass());
				pstmt.setTimestamp(5, article.getRegdate());
				pstmt.setInt(6, ref);
				pstmt.setInt(7, step);
				pstmt.setInt(8, depth);
				pstmt.setString(9, article.getContent());
				pstmt.setString(10, article.getIp());
				
				pstmt.executeUpdate();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
				
			}
			
		} // end insertArticle
		
		/*
		 * 글 목록 화면 작성
		 * 		전체 글의 개수를 가져올 메소드를 구현함
		 *		getArticleCount 
		 */
		
		public int getArticleCount() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 전체 목록을 x에 저장
			int x = 0;
			
			try {
				con = ConnUtil.getConnection();
				String sql = "select count(*) from board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					x = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
				
			}
			return x;
		}
		
		/*
		 * 데이터베이스에 있는 전체 글을 가져다가 리스트에 저장함
		 */
		
		// 페이징 처리
		public List<BoardVO> getArticles(int start, int end){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<BoardVO> articleList = null;
			
			try {
				con = ConnUtil.getConnection();
				// 페이징 처리
				// String sql = "select * from board order by num desc";
				String sql = "select * from (select rownum rnum, num, writer, email, "
						+ "subject, pass, regdate, readcount, ref, step, depth, content, "
						+ "ip from (select * from board order by ref desc, step asc)) "
						+ "where rnum >=? and rnum <=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					// 페이징 처리
					articleList = new ArrayList<BoardVO>(end - start +1);
					do {
						BoardVO article = new BoardVO();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPass(rs.getString("pass"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setStep(rs.getInt("step"));
						article.setDepth(rs.getInt("depth"));
						article.setRegdate(rs.getTimestamp("regdate"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						
						
						articleList.add(article);
					} while(rs.next());
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
			}
			return articleList;
		}
		
		/*
		 * 글 내용 보기
		 * 글의 번호를 매겨변수로 해서 하나의 글에 대한 상세정보를 
		 * 데이터베이스에서 가져옴
		 */
		public BoardVO getArticle(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardVO article = null;
		
			try {
				con = ConnUtil.getConnection();
				String sql1 = "update board set readcount = readcount+1 where num=?";
				pstmt = con.prepareStatement(sql1);
				pstmt.setInt(1, num); // 매개변수의 int num
				pstmt.executeUpdate();
				String sql2 = "select * from board where num=?";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						article = new BoardVO();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPass(rs.getString("pass"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setStep(rs.getInt("step"));
						article.setDepth(rs.getInt("depth"));
						article.setRegdate(rs.getTimestamp("regdate"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
			}
			
			return article;
		} // end getArticle
		
		/*
		 * 글 수정시에는 글목록 보기와 다르게 조회수를 증가시킬 필요가 없다
		 * 조회수를 증가시는 부분을 제외하고 num에 해당하는 게시글만 가져오는 메소드를
		 * 구현한 
		 */
		
		public BoardVO updateGetArticle(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardVO article = null;
		
			try {
				con = ConnUtil.getConnection();
		
				String sql2 = "select * from board where num=?";
				pstmt = con.prepareStatement(sql2);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						article = new BoardVO();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPass(rs.getString("pass"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setStep(rs.getInt("step"));
						article.setDepth(rs.getInt("depth"));
						article.setRegdate(rs.getTimestamp("regdate"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
			}
			return article;
		}
		/*
		 * updateForm.jsp에서 비밀번호를 입력하고 글 수정 버튼을 클릭하면 
		 * 데이터베이스에서 실제 글이 수정 되어야한다.
		 */
			
		public int updateArticle (BoardVO article) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd="";
			String sql="";
			int result = -1;
			
			try {
				con = ConnUtil.getConnection();
				pstmt = con.prepareStatement("select pass from board where num=?");
				pstmt.setInt(1, article.getNum());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpasswd = rs.getString("pass");
					if(dbpasswd.equals(article.getPass())) {
						// 데이터베이스에 저장된 비밀먼호와 내가 입력한 비밀번호가 일치하면 글 수정 처리한다.
						sql="update board set writer=?, email=?, subject=?, content=? where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, article.getWriter());
						pstmt.setString(2, article.getEmail());
						pstmt.setString(3, article.getSubject());
						pstmt.setString(4, article.getContent());
						pstmt.setInt(5, article.getNum());
						pstmt.executeUpdate();
						result = 1;// 글 수정 성공
					} else {
						result = 0; // 글 수정 실패
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
			}
			return result;
		} // end updateArticle
		
		/*
		 * 글삭제 버튼을 클릭하여 글 삭제 화면이 나오면 비밀번호를 입력하고 삭제를 처리한다. 
		 * 이때, 데이터베이스에서 비밀번호를 비교하여 일치하면
		 * 글삭제 처리를 수행한다.
		 */
		
		public int deleteArticle(int num, String pass) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String dbpasswd="";
			String sql="";
			int result = -1;
			
			try {
				con = ConnUtil.getConnection();
				pstmt = con.prepareStatement("select pass from board where num=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpasswd = rs.getString("pass");
					if(dbpasswd.equals(pass)) {
						// 데이터베이스에 저장된 비밀먼호와 내가 입력한 비밀번호가 일치하면 글 수정 처리한다.
						sql="delete from board where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
						result = 1;// 글 삭제 성공
					} else {
						result = 0; // 글 삭제 실패
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
			}
			return result;
			
		}
		
		// 글 검색 및 페이징 처리
		public List<BoardVO> getArticles(String searchWhat, String searchText, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<BoardVO> articleList = null;
			
			try {
				con = ConnUtil.getConnection();
				String sql = "select * from (select rownum rnum, num, writer, email, "
						+ "subject, pass, regdate, readcount, ref, step, depth, content, "
						+ "ip from (select * from board where "+searchWhat+ " like '%"+searchText+"%' order by ref desc, step asc)) "
						+ "where rnum >=? and rnum <=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					// 페이징 처리
					articleList = new ArrayList<BoardVO>(end - start +1);
					do {
						BoardVO article = new BoardVO();
						article.setNum(rs.getInt("num"));
						article.setWriter(rs.getString("writer"));
						article.setEmail(rs.getString("email"));
						article.setSubject(rs.getString("subject"));
						article.setPass(rs.getString("pass"));
						article.setReadcount(rs.getInt("readcount"));
						article.setRef(rs.getInt("ref"));
						article.setStep(rs.getInt("step"));
						article.setDepth(rs.getInt("depth"));
						article.setRegdate(rs.getTimestamp("regdate"));
						article.setContent(rs.getString("content"));
						article.setIp(rs.getString("ip"));
						
						
						articleList.add(article);
					} while(rs.next());
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
				
			}
			return articleList; 
		}
		
		// 글 검색 조건에 해당하는 내용인지 몇개 인지 확인
		public int getArticleCount(String searchWhat, String searchText) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 검색 조건에 해당하는 전체 목록을 y에 저장
			int y = 0;
			
			try {
				con = ConnUtil.getConnection();
				String sql = "select count(*) from board where "+searchWhat+ " like '%"+searchText+"%'";
				
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					y = rs.getInt(1);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
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
					if (con != null)
						con.close();
				} catch (SQLException ss) {
					ss.printStackTrace();
				}
				
			}
			return y;
		}
}
