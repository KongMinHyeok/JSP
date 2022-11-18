package controller.customer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerDAO;
import vo.CustomerVO;

@WebServlet("/customer/modify.do")
public class ModifyController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cusName = req.getParameter("cusName");
		CustomerVO vo = CustomerDAO.getInstance().selectBook(cusName);
		
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/customer/modify.jsp");
		dispatcher.forward(req, resp);
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String cusId = req.getParameter("cusId");
		String cusName = req.getParameter("cusName");
		String cusAddr = req.getParameter("cusAddr");
		String cusHp = req.getParameter("cusHp");
		
		CustomerVO vo = new CustomerVO();
		vo.setCusId(cusId);
		vo.setCusName(cusName);
		vo.setCusAddr(cusAddr);
		vo.setCusHp(cusHp);
		
		CustomerDAO.getInstance().modifyCustomer(vo);
		
		resp.sendRedirect("/Bookstore2/customer/list.do");
		
	}
}
