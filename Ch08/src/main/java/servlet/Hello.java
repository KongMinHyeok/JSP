package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Hello extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@Override
	public void init() throws ServletException {
		// 해당 서블이 최소 실행될떄 한번 호출
		System.out.println("greeting init...");
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청방식이 GET일 경우 호출되는 메서드
		System.out.println("greeting doGet...");
		
		resp.setContentType("text/html;charset=UTF-8");
		
		PrintWriter writer = resp.getWriter();
		writer.println("<html>");
		writer.println("<head>");
		writer.println("<meta charset='UTF-8'/>");
		writer.println("<title>greeting</title>");
		writer.println("</head>");
		writer.println("<body>");
		writer.println("<h3>greeting 서블릿</h3>");
		writer.println("<p>");
		writer.println("<a href='/Ch08/1_서블릿.jsp'>1_서블릿</a><br/>");
		writer.println("<a href='/Ch08/hello.do'>Hello 서블릿</a><br/>");
		writer.println("<a href='/Ch08/welcome.do'>Welcome 서블릿</a><br/>");
		writer.println("<a href='/Ch08/greeting.do'>greeting 서블릿</a><br/>");
		writer.println("</p>");
		writer.println("</body>");
		writer.println("</html>");
		writer.close();
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 요청방식이 POST일 경우 호출되는 메서드
		System.out.println("Hello doPost...");
	}
	@Override
	public void destroy() {
		// 서블릿이 종료될때 호출되는 메서드
		System.out.println("Hello destory...");
	}
}
