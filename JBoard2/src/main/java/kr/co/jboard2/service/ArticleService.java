package kr.co.jboard2.service;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import kr.co.jboard2.dao.articleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {

	INSTANCE;
	private articleDAO dao = articleDAO.getInstance();
	
	public int insertArticle(ArticleVO article) {
		return dao.insertArticle(article);
	}
	
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	
	public int selectCountTotalForSearch(String keyword) {
		return dao.selectCountTotalForSearch(keyword);
	}
	
	public ArticleVO selectArticle(String no) {
		return  dao.selectArticle(no);
		
	}
	
	public List<ArticleVO> selectArticles(int start) {
		return dao.selectArticles(start);
	}
	
	public List<ArticleVO> selectArticleByKeyword(String keyword, int start) {
		return dao.selectArticleByKeyword(keyword, start);
	}
	public void updateArticle() {}
	public void deleteArticle() {}
	
	public MultipartRequest uploadFIle(HttpServletRequest req, String path) throws {
		
	}
	
	public void uploadFile(HttpServletRequest req){
		ServletContext ctx = req.getServletContext();
	}
	
	public String renameFile(ArticleVO vo,  String path) {
		
		
		
		return newName;
	}
	
	
	
	
}
