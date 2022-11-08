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
								alert('성공!');
							}else{
								alert('실패!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>학생관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h3>학생목록</h3>
		<button class="btnregister">등록</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
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
			<h4>학생등록</h4>
			<button class="btnClose">닫기</button>
				<table border="1">
					<tr>
						<td>학번</td>
						<td><input type="text" name="stdNo"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="stdName"></td>
					</tr>
					<tr>
						<td>휴대폰</td>
						<td><input type="text" name="stdHp"></td>
					</tr>
					<tr>
						<td>학년</td>
						<td>
							<select name="stdYear">
								<option value="1">1학년</option>
								<option value="2">2학년</option>
								<option value="3">3학년</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="stdAddress"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="등록"></td>
					</tr>
				</table>
		</section>
	</body>
</html>