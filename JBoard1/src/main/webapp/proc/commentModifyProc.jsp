<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.dao.articleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String content = request.getParameter("content");
	
	int result = articleDAO.getInstance().updateComment(no, content);
	
	// json 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("no", no);
	json.addProperty("content", content);
	
	out.print(json.toString());
	

%>