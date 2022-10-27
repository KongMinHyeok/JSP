package kr.co.jboard1.dao;

public class userDAO {
	
	private static userDAO instance = new userDAO();
	
	public static userDAO getInstance() {
		return instance;
	}
	
	private userDAO() {}
	
	// 기본 CRLD
	
	public void insertUser() {}
	public void selectUser() {}
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
}
