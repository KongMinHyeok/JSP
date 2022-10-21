<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.bookBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	bookBean bk = null;
	
	try{
		Connection conn = DBCP.getConnection("dbcp_java1_bookstore");
		String sql = "select * from `book` where `bookid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			bk = new bookBean();
			bk.setBookId(rs.getInt(1));
			bk.setBookName(rs.getString(2));
			bk.setPubName(rs.getString(3));
			bk.setPrice(rs.getInt(4));
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
		<meta charset="UTF-8">
		<title>Book::register</title>
	</head>
	<body>
		<h3>도서수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">도서목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookid" value="<%= bk.getBookId() %>"/></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="name" value="<%= bk.getBookName() %>"/></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="pub" value="<%= bk.getPubName() %>"/></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" value="<%= bk.getPrice() %>"/></td>
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