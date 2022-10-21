<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");

	String bookid 	= request.getParameter("bookid");
	String name 	= request.getParameter("name");
	String pub  	= request.getParameter("pub");
	String price	= request.getParameter("price");
	
	try{
		
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql  = "UPDATE `book` SET `bookName`=?, `pubName`=?, `price`=? ";
	           sql += "WHERE `bookid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, name);
		psmt.setString(2, pub);
		psmt.setString(3, price);
		psmt.setString(4, bookid);

		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
				
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>