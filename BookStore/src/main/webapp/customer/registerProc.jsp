<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");

	String cusid = request.getParameter("cusid");
	String cusname = request.getParameter("cusname");
	String cusaddr  = request.getParameter("cusaddr");
	String cushp    = request.getParameter("cushp");

	
	
	try{
		
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env");
		
		DataSource ds = (DataSource) ctx.lookup("dbcp_java1_bookstore");
		Connection conn = ds.getConnection();
		
		String sql = "INSERT INTO `customer` VALUES (?,?,?,?)";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, cusid);
		psmt.setString(2, cusname);
		psmt.setString(3, cusaddr);		
		psmt.setString(4, cushp);

		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
				
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>