<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.app.dao.*"%>
	<%@ page import="com.app.service.*"%>
	<%@ page import="com.app.security.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="./assets/css/stripe-style.css">
</head>
<body>
	<%
	DAOImpl dao = DAOImpl.getInstance();
	String token = test.getCookie(request);
	String username = JWTUtil.getUsername(token);
	int result = dao.proceedSale(username);
	%>
	<section>
		<p>Hooray! Payment successful. Thank you for shopping with ManageMed!
		We would be happy to hear from you.</p>
		<p>
			<a href="mailto:orders@example.com">pal.sayantika26@gmail.com</a>
		</p>
		<form action="Home.jsp" method="post">
			<button type="submit">Home</button>
		</form>
	</section>
	<script src="./js/viewcart.js"></script>
</body>
</html>