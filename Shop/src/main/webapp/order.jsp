
<%@page import="config.sql"%>
<%@page import="bean.orderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<orderBean> orb = new ArrayList<>();

	request.setCharacterEncoding("utf-8");
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql.SELECT_ORDER);
		
		while(rs.next()){
			orderBean ob = new orderBean();
			ob.setOrderNo(rs.getInt(1));
			ob.setName(rs.getString(2));
			ob.setProName(rs.getString(3));
			ob.setOrdercount(rs.getInt(4));
			ob.setOrderdate(rs.getString(5));
			
			
			orb.add(ob);
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
		<title>shop:customer</title>
	</head>
	<body>
		<h3>주문목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<% for(orderBean ob : orb)  {%>
			<tr>
				<td><%= ob.getOrderNo() %></td>
				<td><%= ob.getName() %></td>
				<td><%= ob.getProName() %></td>
				<td><%= ob.getOrdercount() %></td>
				<td><%= ob.getOrderdate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>