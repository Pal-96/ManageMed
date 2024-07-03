<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.app.dao.*"%>
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
	int result = dao.proceedSale();
	%>
	<section>
		<p>Your payment is successful. We appreciate your business! If you
			have any questions, please email below.</p>
		<p>
			<a href="mailto:orders@example.com">pal.sayantika26@gmail.com</a>
		</p>
		<form action="Home.jsp" method="post">
			<button type="submit">Home</button>
		</form>
	</section>
</body>
</html>