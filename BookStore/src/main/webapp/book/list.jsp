<%@page import="config.DBCP"%>
<%@page import="bean.bookBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	

	
	List<bookBean> books = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `book`");
		
		while(rs.next()){
			
			bookBean bk = new bookBean();
			bk.setBookId(rs.getInt(1));
			bk.setBookName(rs.getString(2));
			bk.setPubName(rs.getString(3));
			bk.setPrice(rs.getInt(4));
			
			books.add(bk);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
		
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>book::list</title>
	</head>
	<body>
		<h3>도서 목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">도서등록</a>
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<% for (bookBean bk : books) { %>
			<tr>
				<td><%= bk.getBookId() %></td>
				<td><%= bk.getBookName() %></td>
				<td><%= bk.getPubName() %></td>
				<td><%= bk.getPrice() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= bk.getBookId() %>">수정</a>
					<a href="./delete.jsp?uid=<%= bk.getBookId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>		
	</body>
</html>