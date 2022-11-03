<%@page import="kr.co.jboard1.dao.articleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	articleDAO.getInstance().updateArticle(title, content, no);
	
	response.sendRedirect("/JBoard1/view.jsp?no="+no+"&pg"+pg);

%>