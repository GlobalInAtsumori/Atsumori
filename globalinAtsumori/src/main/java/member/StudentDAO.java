package member;

import java.awt.Window;
import java.sql.*;
import javax.sql.*;

import javax.naming.*;
import java.util.*;

public class StudentDAO {

	private Connection getConnection() {
		Connection con = null; //객체 만들기
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			con = ds.getConnection();
			
		}catch(Exception e) {
			System.out.println("Connection 생성 실패 !!!!");
		}
		return con;
	}
	
	// 아이디 체크 메소드 구현
	public boolean idCheck(String id) {
		boolean result = true;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			String sql1 = "select * from student where id=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(!rs.next()) result = false;
		}catch(SQLException s){
			s.printStackTrace();
		}finally {
			
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
	} // end idCheck
	
	//우편번호를 데이터베이스에서 검색해서 컬렉션에 저장해서 리턴해주는 메소드 구현
	//저장해서 리턴해주는 메소드 구현
	public Vector<ZipCodeVO> zipcodeRead(String dong) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ZipCodeVO> vecList = new Vector<ZipCodeVO>();
		
		try {
			con = getConnection();
			String sql="select * from zipcode where dong like '" + dong + "%'";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				 ZipCodeVO tZipcode = new ZipCodeVO();
				 tZipcode.setZipcode(rs.getString("zipcode"));
				 tZipcode.setSido(rs.getString("sido"));
				 tZipcode.setGugun(rs.getString("gugun"));
				 tZipcode.setDong(rs.getString("dong"));
				 tZipcode.setRi(rs.getString("ri"));
				 tZipcode.setBunji(rs.getString("bunji"));
				 vecList.addElement(tZipcode);
				
			}
			
		}catch(SQLException s) {
			s.printStackTrace();
		}finally {
			
			
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
		
		return vecList;
	}
	
	/*
	 *  회원 가입 처리 구현
	 * 데이터 베이스에 회원 테이터를 저장하기 위한 메소드 구현
	 */
	
	public boolean memberInsert(StudentVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		
		try {
			con = getConnection();
			String sql = "insert into student values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPass());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getPhone1());
			pstmt.setString(5, vo.getPhone2());
			pstmt.setString(6, vo.getPhone3());
			pstmt.setString(7, vo.getEmail());
			pstmt.setString(8, vo.getZipcode());
			pstmt.setString(9, vo.getAddress1());
			pstmt.setString(10, vo.getAddress2());
			
			int count = pstmt.executeUpdate();
			if(count > 0) flag = true;
			
		}catch(Exception e) {
			System.out.println("Exception : "+e);
		}finally {
			
			
			
			
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
		
		return flag;
	}
	
	/*	로그인 구현
	 * 
	 * 로그인 버튼을 클릭하면 입력한 id/password를 데이터버ㅔ이스에 저장되어 있는
	 * id/password와 비교해서 같으면 로그인 성공 다르면 로그인 실패
	 * 
	 * 		1:로그인 성공, 0: 비밀번호 오류, -1: 아이디가 존재하지 않음
	 * 
	 */
	
	public int loginCheck(String id, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;// 아이디가 존재하지 않음
		
		try {
			con = getConnection();
			
			String sql = "select pass from student where id=?"; //입력한 id를 이용해서 패스워드를 조회한다.
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String dbPass = rs.getString("pass");
				if(pass.equals(dbPass)) {
					check = 1; //로그인 성공
				}else {
					check = 0; //비밀번호 오류
				}
			}
			
			/*
			while(rs.next()) {
				String dbPass = rs.getString("pass");
				if(pass.equals(dbPass)) {
					check = 1; //로그인 성공
				}else {
					check = 0; //비밀번호 오류
				}
			}
			*/
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
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
		return check;
		
	}
	
	/*	   정보수정
	 * 		-정보 수정 버튼을 클릭하면 현재 로그인한 회원의 정보를 수정할 수 있도록 미리
	 * 		 데이터베이스에서 정보를 가져온다.
	 * 		 회원정보를 가져올 메소드 구현
	 * 		getMember(String id)
	 */
	
	public StudentVO getMember(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StudentVO vo = null;

		try {
			String sql = "select * from student where id=?";
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //아이디에 해당하는 회원이 존재한다면
				
				vo = new StudentVO();
				vo.setId(rs.getString("id"));
				vo.setPass(rs.getString("pass"));
				vo.setName(rs.getString("name"));
				vo.setPhone1(rs.getString("phone1"));
				vo.setPhone2(rs.getString("phone2"));
				vo.setPhone3(rs.getString("phone3"));
				vo.setEmail(rs.getString("email"));
				vo.setZipcode(rs.getString("zipcode"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
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
		
		return vo;
	}
	
	/*
	 * 		회원정보수정 버튼을 클릭하면 데이터베이스에서 수정처리를 실행한다.
	 */
	
	public void updateMember(StudentVO vo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = getConnection();
			String sql="update student set pass=?, phone1=?, phone2=?, "
					+ "phone3=?, email=?, zipcode=?, "
					+ "address1=?, address2=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPass());
			pstmt.setString(2, vo.getPhone1());
			pstmt.setString(3, vo.getPhone2());
			pstmt.setString(4, vo.getPhone3());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getZipcode());
			pstmt.setString(7, vo.getAddress1());
			pstmt.setString(8, vo.getAddress2());
			pstmt.setString(9, vo.getId());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			

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
	
	/*회원탈퇴 버튼을 클릭하면 데이터베이스에서 회원데이터가 삭제 되어야함
	 * 회원삭제를 처리할 메소드를 구현함
	 * 
	 * 
	 */
	public int deleteMember(String id, String pass) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		String dbPass="";
		
		
		try {
			
			String sql1 ="select pass from student where id=?";
			con = getConnection();
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbPass = rs.getString("pass");
				if(dbPass.equals(pass)) {//본인 인증 성공
					String sql2="delete from student where id=?";
					pstmt = con.prepareStatement(sql2);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					result =1;//회원 탈퇴 성공
				}else {
					result = 0;
				}
			}
			
			
			
			
		}catch(SQLException ss) {
			ss.printStackTrace();
			
		}finally {
			
			
			try {
				if(pstmt != null)
				   pstmt.close();
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
	
	
}

