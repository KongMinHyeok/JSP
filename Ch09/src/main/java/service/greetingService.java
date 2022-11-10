package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class greetingService {

	private static greetingService instance = new greetingService();
	public static greetingService getInstance() {
		return instance;
	}
	
	private greetingService() {}
	
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/greeting.jsp";
		
	}
}
