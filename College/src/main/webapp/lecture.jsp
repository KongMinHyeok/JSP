<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.lecBean"%>
<%@page import="java.util.List"%>
<%@page import="db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String lecno = request.getParameter("lecno");
	String lecName = request.getParameter("lecName");
	String lecCredit = request.getParameter("lecCredit");
	String lecTime = request.getParameter("lecTime");
	String lecClass = request.getParameter("lecClass");
	
	List<lecBean> lectures = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_LECTURE);
		
		while(rs.next()){
			lecBean lb = new lecBean();
			lb.setLecno(rs.getInt(1));
			lb.setLecName(rs.getString(2));
			lb.setLecCredit(rs.getInt(3));
			lb.setLecTime(rs.getInt(4));
			lb.setLecClass(rs.getString(5));
			
			lectures.add(lb);
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
		<title>College::lecture</title>
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

					let lecno = $('input[name=lecno]').val();
					let lecName = $('input[name=lecName]').val();
					let lecCredit = $('input[name=lecCredit]').val();
					let lecTime = $('input[name=lecTime]').val();
					let lecClass = $('input[name=lecClass]').val();
					
					let jsonData = {
							"lecno":lecno ,
							"lecName":lecName ,
							"lecCredit":lecCredit ,
							"lecTime":lecTime ,
							"lecClass":lecClass ,
					};
					
					console.log(jsonData);
					
					$.ajax({
						url:'/College/proc/lectureProc.jsp',
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
		<h3>강좌관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h3>강좌현황</h3>
		<button class="btnregister">등록</button>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장</th>
			</tr>
			<% for (lecBean lb : lectures) { %>
			<tr>
				<td><%= lb.getLecno() %></td>
				<td><%= lb.getLecName() %></td>
				<td><%= lb.getLecCredit() %></td>
				<td><%= lb.getLecTime() %></td>
				<td><%= lb.getLecClass() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none" class="sectionForm">
			<h4>강좌등록</h4>
			<button class="btnClose">닫기</button>
				<table border="1">
					<tr>
						<td>번호</td>
						<td><input type="text" name="lecno"></td>
					</tr>
					<tr>
						<td>강좌명</td>
						<td><input type="text" name="lecName"></td>
					</tr>
					<tr>
						<td>학점</td>
						<td><input type="text" name="lecCredit"></td>
					</tr>
					<tr>
						<td>시간</td>
						<td><input type="text" name="lecTime"></td>
					</tr>
					<tr>
						<td>강의장</td>
						<td><input type="text" name="lecClass"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="추가"></td>
					</tr>
				</table>
		</section>
	</body>
</html>