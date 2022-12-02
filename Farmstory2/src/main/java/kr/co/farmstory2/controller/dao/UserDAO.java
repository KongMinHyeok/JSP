package kr.co.farmstory2.controller.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.controller.db.DBHelper;
import kr.co.farmstory2.controller.db.Sql;
import kr.co.farmstory2.controller.vo.TermVO;

public class UserDAO extends DBHelper{

	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	
	private UserDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public TermVO selectTerms() {
		
		TermVO vo = null;
		try {
			logger.info("selectTerms start...");
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_TERMS);
			
			if(rs.next()) {
				vo = new TermVO();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			
			close();
			
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		logger.debug("vo : " + vo);
		return vo;
	}
	
	public int selectCountUid(String uid) {
		
		int result = 0;
		
		try {
			logger.info("selectCountUid start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_USER);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	public int selectCountNick(String nick) {
		
		int result = 0;
		
		try {
			logger.info("selectCountNick start...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			close();
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	
	public void insertUser() {
		
		try {
			logger.info("insertUser start...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_USER);
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
}
