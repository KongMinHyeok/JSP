<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");

	String cusid 	= request.getParameter("cusid");
	String cusname 	= request.getParameter("cusname");
	String cusaddr  	= request.getParameter("cusaddr");
	String cushp	= request.getParameter("cushp");
	
	try{
		
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		
		String sql  = "UPDATE `customer` SET `cusname`=?, `cusaddr`=?, `cushp`=? ";
	           sql += "WHERE `cusid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, cusname);
		psmt.setString(2, cusaddr);
		psmt.setString(3, cushp);
		psmt.setString(4, cusid);

		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
				
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>