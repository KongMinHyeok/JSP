package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class welcomeService {

	private static welcomeService instance = new welcomeService();
	public static welcomeService getInstance() {
		return instance;
	}
	
	private welcomeService() {
		
	}
	
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/welcome.jsp";
		
	}
}
