package dao;

public class SecondhandDAO {
	private static SecondhandDAO instance = null;
	public SecondhandDAO() {
	}
	
	public static SecondhandDAO getInstance() {
		
		if(instance == null) {
			
			synchronized (SecondhandDAO.class) {
				instance = new SecondhandDAO();
			}
		}
		
		return instance;
		
	}
	
	
	
}
