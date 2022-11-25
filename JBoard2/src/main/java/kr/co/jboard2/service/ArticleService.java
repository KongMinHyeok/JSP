package kr.co.jboard2.service;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import kr.co.jboard2.dao.articleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {

	INSTANCE;
	
	private articleDAO dao = articleDAO.getInstance();
	
	public int insertArticle(articleDAO article) {
		return dao.insertArticle(article);
	}
	
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	
	public ArticleVO selectArticle(String no) {
		return  dao.selectArticle(no);
		
	}
	public List<ArticleVO> selectArticles(int start) {
		return dao.selectArticles(start);
	}
	public void updateArticle() {}
	public void deleteArticle() {}
	
	public void uploadFile(HttpServletRequest req){
		ServletContext ctx = req.getServletContext();
	}
	
	public String renameFile(ArticleVO vo,  String path) {
		
		
		
		return newName;
	}
	
	
}
