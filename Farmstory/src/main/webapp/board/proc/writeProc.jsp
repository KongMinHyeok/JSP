<%@page import="kr.co.farmstory.bean.ArticleBean"%>
<%@page import="kr.co.farmstory.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String group   = request.getParameter("group");
	String cate	   = request.getParameter("cate");
	String uid	   = request.getParameter("uid");
	String title   = request.getParameter("title");
	String content = request.getParameter("content");
	String regip   = request.getRemoteAddr();
	
	
	ArticleBean ab = new ArticleBean();
	ab.setCate(cate);
	ab.setTitle(title);
	ab.setContent(content);
	ab.setFile(0);
	ab.setUid(uid);
	ab.setRegip(regip);
	
	ArticleDAO.getInstance().insertArticle(ab);
	
	response.sendRedirect("/Farmstory/board/list.jsp?group="+group+"&cate="+cate);
%>