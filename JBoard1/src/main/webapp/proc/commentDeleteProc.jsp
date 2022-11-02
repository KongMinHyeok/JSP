<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.dao.articleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	int result = articleDAO.getInstance().deleteComment(no);
	
	// json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	out.print(json.toString());
%>