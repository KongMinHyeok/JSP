<%@page import="com.google.gson.JsonObject"%>
<%@page import="db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.lecBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	String StdName = request.getParameter("StdName");
	String lecName = request.getParameter("lecName");
	String regLecNo = request.getParameter("regLecNo");

	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement(Sql.INSERT_REGISTER);
		
		psmt.setString(1, regStdNo);
		psmt.setString(2, StdName);
		psmt.setString(3, lecName);
		psmt.setString(4, regLecNo);
		
		result = psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);
%>