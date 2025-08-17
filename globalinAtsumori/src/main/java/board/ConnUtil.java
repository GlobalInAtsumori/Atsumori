package board;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnUtil {
	
    // DataSource 객체를 저장할 static 변수 (커넥션 풀)
	private static DataSource ds;
	
    // static 초기화 블럭 : 클래스가 로딩될 때 실행됨
	static {
		try {
            // JNDI를 사용해 context를 초기화
			Context initContext = new InitialContext();
			
            // 환경 설정 context ("java:/comp/env")를 찾음
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			
            // context로부터 DataSource 객체를 lookup ("jdbc/myoracle"은 context.xml에서 정의)
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		}catch(NamingException ne) {
            // 예외 발생 시 스택 추적 출력
			ne.printStackTrace();
		}
	}
	
    // 커넥션을 얻어오는 메소드 (DAO 클래스에서 사용)
	public static Connection getConnection() throws SQLException{
		return ds.getConnection();
	}
	
	
}
