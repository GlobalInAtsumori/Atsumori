package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";  // 오라클 드라이버
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // 오라클 DB URL
    private static final String USER = "your_db_username";                   // 사용자 이름
    private static final String PASSWORD = "your_db_password";               // 비밀번호

    public static Connection getConnection() {
        Connection conn = null;

        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }
}
