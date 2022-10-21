<%@page import="config.DBCP"%>
<%@page import="bean.customerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	
	List<customerBean> cusb = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
		
		while(rs.next()){
			
			customerBean cb = new customerBean();
			cb.setCusId(rs.getInt(1));
			cb.setCusName(rs.getString(2));
			cb.setCusAddr(rs.getString(3));
			cb.setCusHp(rs.getString(4));
			
			cusb.add(cb);
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
		<title>customer::list</title>
	</head>
	<body>
		<h3>고객 목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">고객등록</a>
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>

			</tr>
			<% for (customerBean cb : cusb) { %>
			<tr>
				<td><%= cb.getCusId() %></td>
				<td><%= cb.getCusName() %></td>
				<td><%= cb.getCusAddr() %></td>
				<td><%= cb.getCusHp() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= cb.getCusId() %>">수정</a>
					<a href="./delete.jsp?uid=<%= cb.getCusId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>		
	</body>
</html>