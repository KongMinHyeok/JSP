<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addrUser</title>
	</head>
	<body>
		<h3>addrUser</h3>
		<%
			request.setCharacterEncoding("UTF-8");
		%>
		<jsp:useBean id="au" class="bean.User2Bean">
			<jsp:setProperty property="name" name="au"/><br/>
			<jsp:setProperty property="age" name="au"/><br/>
			<jsp:setProperty property="hp" name="au"/><br/>
			<jsp:setProperty property="addr" name="au"/><br/>
		</jsp:useBean>
		<p>
			이름 : <%= au.getName() %><br/>
			나이 : <%= au.getAge() %><br/>
			전화번호 : <%= au.getHp() %><br/>
			주소 : <%= au.getAddr() %><br/>
		</p>
		
		<a href="../3_useBean 액션태그.jsp">뒤로가기</a>
	</body>
</html>