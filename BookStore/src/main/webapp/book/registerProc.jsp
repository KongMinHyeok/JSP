<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	String bookid = request.getParameter("bookid");
	String name = request.getParameter("name");
	String pub  = request.getParameter("pub");
	String price    = request.getParameter("price");

	
	
	try{
		
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("dbcp_java1_bookstore");
		Connection conn = ds.getConnection();
		
		String sql = "INSERT INTO `book` VALUES (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, bookid);
		psmt.setString(2, name);
		psmt.setString(3, pub);
		psmt.setString(4, price);

		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
				
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>