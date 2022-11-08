<%@page import="bean.rgBean"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="db.Sql"%>
<%@page import="db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String regStdNo = request.getParameter("regStdNo");
	String StdName = request.getParameter("StdName");
	String lecName = request.getParameter("lecName");
	String regLecNo = request.getParameter("regLecNo");
	String regMidScore = request.getParameter("regMidScore");
	String regFinalScore = request.getParameter("regFinalScore");
	String regTotalScore = request.getParameter("regTotalScore");
	String regGrade = request.getParameter("regGrade");
	
	List<rgBean> registers = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_REGISTER);
		
		while(rs.next()){
			rgBean rb = new rgBean();
			rb.setRegStdNo(rs.getString(1));
			rb.setStdName(rs.getString(2));
			rb.setLecName(rs.getString(3));
			rb.setRegLecNo(rs.getInt(4));
			rb.setRegMidScore(rs.getInt(5));
			rb.setRegFinalScore(rs.getInt(6));
			rb.setRegTotalScore(rs.getInt(7));
			rb.setRegGrade(rs.getString(8));
			
			registers.add(rb);
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
		let isregSNOK = false;
		
			$(function(){
				$('.btnregister').click(function(){
					$('section').show();
				});
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('input[type=submit]').click(function(){

					let regStdNo= $('input[name=regStdNo]').val();
					let StdName = $('input[name=StdName]').val();
					let lecName = $('input[name=lecName]').val();
					let regLecNo = $('input[name=regLecNo]').val();
					
					let jsonData = {
							"regStdNo":regStdNo,
							"StdName":StdName,
							"lecName":lecName,
							"regLecNo":regLecNo,
					};
					
					console.log(jsonData);
					
					$.ajax({
						url:'/College/proc/registerProc.jsp',
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
		<h3>수강관리</h3>
		<a href="./lecture.jsp">강좌관리</a>
		<a href="./register.jsp">수강관리</a>
		<a href="./student.jsp">학생관리</a>
		
		<h3>수강현황</h3>
		<input type="text" name="regSN" value="학번입력"><button class="btnrgb">검색</button>
		<button class="btnregister">수강신청</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
			<% for (rgBean rb : registers) { %>
			<tr>
				<td><%= rb.getRegStdNo() %></td>
				<td><%= rb.getStdName() %></td>
				<td><%= rb.getLecName() %></td>
				<td><%= rb.getRegLecNo() %></td>
				<td><%= rb.getRegMidScore() %></td>
				<td><%= rb.getRegFinalScore() %></td>
				<td><%= rb.getRegTotalScore() %></td>
				<td><%= rb.getRegGrade() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display: none">
			<h4>수강신청</h4>
			<button class="btnClose">닫기</button>
				<table border="1">
					<tr>
						<td>학번</td>
						<td><input type="text" name="regStdNo"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="StdName"></td>
					</tr>
					<tr>
						<td>신청강좌</td>
						<td>
							<select name="lecName">
								<option>강좌선택</option>
							<% for (rgBean rb : registers){ %>
								<option><%=rb.getLecName() %></option>
							<% } %>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right"><input type="submit" value="신청"></td>
					</tr>
				</table>
		</section>
	</body>
</html>