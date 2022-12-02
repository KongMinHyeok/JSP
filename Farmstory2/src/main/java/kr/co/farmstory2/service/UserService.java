package kr.co.farmstory2.service;

import kr.co.farmstory2.controller.dao.UserDAO;

public enum UserService {

	instance;
	
	private UserDAO udao = UserDAO.getInstance();
	
	public int selectCountUid(String uid) {
		return udao.selectCountUid(uid);
	}
	
	public int selectCountNick(String nick) {
		return udao.selectCountNick(nick);
	}
	
}
