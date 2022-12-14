<%@page import="bean.stdBean"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String stdNo = request.getParameter("stdNo");
	String stdName = request.getParameter("stdName");
	String stdHp = request.getParameter("stdHp");
	String stdYear = request.getParameter("stdYear");
	String stdAddress = request.getParameter("stdAddress");
	
	List<stdBean> students = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_STUDENT);
		
		while(rs.next()){
			stdBean sb = new stdBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdName(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getString(4));
			sb.setStdAddress(rs.getString(5));
			
			students.add(sb);
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
		<title>College::Student</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.btnregister').click(function(){
					$('section').show();
				});
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('input[type=submit]').click(function(){

					let stdNo = $('input[name=stdNo]').val();
					let stdName = $('input[name=stdName]').val();
					let stdHp = $('input[name=stdHp]').val();
					let stdYear = $('select[name=stdYear]').val();
					let stdAddress = $('input[name=stdAddress]').val();
					
					let jsonData = {
							"stdNo":stdNo ,
							"stdName":stdName ,
							"stdHp":stdHp ,
							"stdYear":stdYear ,
							"stdAddress":stdAddress ,
					};
					
					console.log(jsonData);
					
					$.ajax({
						url:'/College/proc/studentProc.jsp',
						type:'POST',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data.result == 1){
								alert('??????!');
							}else{
								alert('??????!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>????????????</h3>
		<a href="./lecture.jsp">????????????</a>
		<a href="./register.jsp">????????????</a>
		<a href="./student.jsp">????????????</a>
		
		<h3>????????????</h3>
		<button class="btnregister">??????</button>
		<table border="1">
			<tr>
				<th>??????</th>
				<th>??????</th>
				<th>?????????</th>
				<th>??????</th>
				<th>??????</th>
			</tr>
			<% for (stdBean sb : students) { %>
			<tr>
				<td><%= sb.getStdNo() %></td>
				<td><%= sb.getStdName() %></td>
				<td><%= sb.getStdHp() %></td>
				<td><%= sb.getStdYear() %></td>
				<td><%= sb.getStdAddress() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none">
			<h4>????????????</h4>
			<button class="btnClose">??????</button>
				<table border="1">
					<tr>
						<td>??????</td>
						<td><input type="text" name="stdNo"></td>
					</tr>
					<tr>
						<td>??????</td>
						<td><input type="text" name="stdName"></td>
					</tr>
					<tr>
						<td>?????????</td>
						<td><input type="text" name="stdHp"></td>
					</tr>
					<tr>
						<td>??????</td>
						<td>
							<select name="stdYear">
								<option value="1">1??????</option>
								<option value="2">2??????</option>
								<option value="3">3??????</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>??????</td>
						<td><input type="text" name="stdAddress"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="??????"></td>
					</tr>
				</table>
		</section>
	</body>
</html>