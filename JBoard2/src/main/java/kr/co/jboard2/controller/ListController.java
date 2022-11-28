package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet  {
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		
		int currentPage = service.getCurrentPage(pg); // 현재 페이지 번호
		int total = 0;
		
		if(search == null) {
			total = service.selectCountTotal();
		}else {
			total = service.selectCountTotalForSearch(search);
		}
		
		int start = service.getStartNum(currentPage); // 시작 인덱스
		List<ArticleVO> articles = null;
		service.selectArticles(start)
		if(search == null) {
			articles = service.selectCountTotal();
		}else {
			articles = service.selectCountTotalForSearch(search);
		}
		req.setAttribute("articles", articles);
		req.setAttribute("articles", articles);
		req.setAttribute("articles", articles);
		req.setAttribute("articles", articles);
		req.setAttribute("articles", articles);
		req.setAttribute("search", search);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}