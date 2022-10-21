<%@page import="java.sql.PreparedStatement"%>
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
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	customerBean cusb = null;
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		String sql = "select * from `customer` where `cusid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			
			cusb = new customerBean();
			cusb.setCusId(rs.getInt(1));
			cusb.setCusName(rs.getString(2));
			cusb.setCusAddr(rs.getString(3));
			cusb.setCusHp(rs.getString(4));
		}
		
		rs.close();
		psmt.close();
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
		<h3>고객수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">고객목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>고객번호</td>
					<td><input type="number" name="cusid" value="<%= cusb.getCusId() %>"/></td>
				</tr>
				<tr>
					<td>고객명</td>
					<td><input type="text" name="cusname" value="<%= cusb.getCusName() %>"/></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="cusaddr" value="<%= cusb.getCusAddr() %>"/></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="cushp" value="<%= cusb.getCusHp() %>"/></td>
				</tr>

				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록하기">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>