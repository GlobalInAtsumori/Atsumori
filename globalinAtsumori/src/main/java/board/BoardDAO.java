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
		
		
		//=============글 추가================================
		/*
		 * 실제 데이터베이스에 데이터를 저장할 메소드를 구현
		 * insertArticle(BoardVO article)
		 */	
		
		public void insertArticle(BoardVO article) {
			Connection con = null;	//데이터베이스 연결 객체
			// 조회를 위해, 무엇이 들어갈지 모르는 경우
			PreparedStatement pstmt = null;	//SQL 실행 객체
			ResultSet rs = null;	//조회 결과 저장 객체
			
			int num = article.getBoardno();
			
			/*
			int ref = article.getRef();
			int step = article.getStep();
			int depth = article.getDepth();
			*/
			
			int number = 0;
			
			String sql = "";
			
			try {
				con = ConnUtil.getConnection();	//DB 연결
				pstmt = con.prepareStatement("select max(num) from board2");	//현재 글 중 가장 큰 번호 조회
				rs= pstmt.executeQuery();
				
				// 새글일 경우 글 번호 결정
				if(rs.next()) number = rs.getInt(1)+1;
				else number = 1;
				
				sql = "insert into board2(boardno, title, content, createdate, memberno, regdate) "
						+ "values(board_seq2.nextval, ?, ?, ? , ? )";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, article.getTitle());
				pstmt.setString(2, article.getContent());
				pstmt.setDate(3, article.getCreatedate());
				pstmt.setInt(4, article.getMemberno());

				pstmt.executeUpdate();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				//사용한 DB 리소스 닫기
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
		
		
		//=========== 전체 글 개수 가져오기 ==================
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
				String sql = "select count(*) from board2";	//글 개수 조회
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
		
		
		//==================== 글 목록 가져오기 (페이징 처리 포함)==============
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
				// rownum을 이용해 페이징 처리
				// String sql = "select * from board order by num desc";
				String sql = "select * from (select rownum rnum, boardno, title, content, "
						+ "createdate, memberno from where rnum >=? and rnum <=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					// 페이징 처리
					articleList = new ArrayList<BoardVO>(end - start +1);
					do {
						BoardVO article = new BoardVO();
						article.setBoardno(rs.getInt("boardno"));
						article.setTitle(rs.getString("title"));
						article.setContent(rs.getString("content"));
						article.setCreatedate(rs.getDate("createdate"));
						article.setMemberno(rs.getInt("memberno"));
						
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
		
		
		//==============글 내용 보기=======================
		/*
		 * getArticle(int num)
		 * 글의 번호를 매겨변수로 해서 하나의 글에 대한 상세정보를 데이터베이스에서 가져옴
		 */
		public BoardVO getArticle(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardVO article = null;
		
			try {
				con = ConnUtil.getConnection();
				
				String sql = "select * from board2 where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						article = new BoardVO();
						article.setBoardno(rs.getInt("boardno"));
						article.setTitle(rs.getString("title"));
						article.setContent(rs.getString("content"));
						article.setCreatedate(rs.getDate("createdate"));
						article.setMemberno(rs.getInt("memberno"));
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
		
		
		//================ 글 수정용 글 정보 가져오기 ======================
		/*
		 * updateGetArticle(int num)
		 * 글 수정시에는 글목록 보기와 다르게 조회수를 증가시킬 필요가 없다
		 * 조회수를 증가시는 부분을 제외하고 num에 해당하는 게시글만 가져오는 메소드를 구현..
		 */
		
		public BoardVO updateGetArticle(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardVO article = null;
		
			try {
				con = ConnUtil.getConnection();
		
				String sql = "select * from board2 where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					article = new BoardVO();
					article.setBoardno(rs.getInt("boardno"));
					article.setTitle(rs.getString("title"));
					article.setContent(rs.getString("content"));
					article.setCreatedate(rs.getDate("createdate"));
					article.setMemberno(rs.getInt("memberno"));
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
		
		
		//=============== 글 수정 =======================
		
		//updateArticle(BoardVO article)
		
		//updateForm.jsp에서 비밀번호를 입력하고 글 수정 버튼을 클릭하면 
		//데이터베이스에서 실제 글이 수정 되어야한다. (이제 필요없는 코드)
		// 
		//글 수정 시 비밀번호 확인 후 수정
		//성공: 1, 비밀번호 불일치: 0, 오류: -1
			
		public void updateArticle (BoardVO article) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql="";
			
			
			try {
				con = ConnUtil.getConnection();
				pstmt = con.prepareStatement("select pass from board2 where num=?");
				pstmt.setInt(1, article.getBoardno());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						sql="update board2 set writer=?, email=?, subject=?, content=? where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, article.getBoardno());
						pstmt.setString(2, article.getTitle());
						pstmt.setString(3, article.getContent());
						pstmt.setDate(4, article.getCreatedate());
						pstmt.setInt(5, article.getMemberno());
						
						pstmt.executeUpdate();
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
			
		} // end updateArticle
		
		
		//=============== 글 삭제 ================================
		
		public void deleteArticle(int num, String pass) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql="";
			
			try {
				con = ConnUtil.getConnection();
				pstmt = con.prepareStatement("select pass from board2 where num=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						sql="delete from board2 where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
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
			
		}
		
		
		//======================글 검색 + 페이징 처리 ===========================
		// 글 검색 및 페이징 처리
		public List<BoardVO> getArticles(String searchWhat, String searchText, int start, int end) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<BoardVO> articleList = null;
			
			try {
				con = ConnUtil.getConnection();
				String sql = "select * from (select rownum rnum, boardno, title, content, createdate, memberno "
						+ "from (select * from board2 where "+searchWhat+ " like '%"+searchText+"%' order by ref desc, step asc)) "
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
						article.setBoardno(rs.getInt("boardno"));
						article.setTitle(rs.getString("title"));
						article.setContent(rs.getString("content"));
						article.setCreatedate(rs.getDate("createdate"));
						article.setMemberno(rs.getInt("memberno"));
						
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
		
		
		//============= 검색 글 개수 가져오기 ============================
		// 글 검색 조건에 해당하는 내용인지 몇개 인지 확인
		public int getArticleCount(String searchWhat, String searchText) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			// 검색 조건에 해당하는 전체 목록을 y에 저장
			int y = 0;
			
			try {
				con = ConnUtil.getConnection();
				String sql = "select count(*) from board2 where "+searchWhat+ " like '%"+searchText+"%'";
				
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
