<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.app.dao.*"%>
	<%@ page import="com.app.service.*"%>
	<%@ page import="com.app.security.*"%>
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
	dao.restoreStock(username);
	%>
	
<section>
    <p>Forgot to add something to your cart? Shop around then come back to pay!</p>
    <form action="Home.jsp" method="post">
			<button type="submit">Home</button>
		</form>
  </section>

</body>
</html>