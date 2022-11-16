<%@page import="kr.co.farmstory.bean.UserBean"%>
<%@page import="kr.co.farmstory.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();
	response.sendRedirect("/Farmstory");

%>