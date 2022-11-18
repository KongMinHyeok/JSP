package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.BookVO;

public class BookDAO extends DBHelper{

	private static BookDAO instance = new BookDAO();
	public static BookDAO getInstance() {
		return instance;
	}
	
	private BookDAO() {}
	
	public BookVO selectBook (String bookName) {
		BookVO vo = null;
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `book` where `bookName`=?");
			psmt.setString(1, bookName);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new BookVO();
				vo.setBookId(rs.getInt(1));
				vo.setBookName(rs.getString(2));
				vo.setPubName(rs.getString(3));
				vo.setPrice(rs.getInt(4));
			}
			
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public List<BookVO> selectBooks() {
		
		List<BookVO> books = new ArrayList<>();
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `book`");
			
			while(rs.next()) {
				BookVO vo = new BookVO();
				vo.setBookId(rs.getInt(1));
				vo.setBookName(rs.getString(2));
				vo.setPubName(rs.getString(3));
				vo.setPrice(rs.getInt(4));
				books.add(vo);
			}
			
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return books;
		
	}
	public void insertBook (BookVO vo) {
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("insert into `book` values (?,?,?,?)");
			psmt.setInt(1, vo.getBookId());
			psmt.setString(2, vo.getBookName());
			psmt.setString(3, vo.getPubName());
			psmt.setInt(4, vo.getPrice());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void modifyBook (BookVO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `book` set `bookName`=?, `pubName`=?, `price`=? where `bookId`=?");
			psmt.setString(1, vo.getBookName());
			psmt.setString(2, vo.getPubName());
			psmt.setInt(3, vo.getPrice());
			psmt.setInt(4, vo.getBookId());
			psmt.executeUpdate();
			close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteBook (String BookName) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `book` where `bookName`=?");
			psmt.setString(1, BookName);
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}
