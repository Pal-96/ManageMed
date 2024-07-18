<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.app.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.app.service.*"%>
<%@ page import="com.app.security.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="./assets/css/custom.css"></link>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%
	String token = test.getCookie(request);
	String cartcount = "0";
	if (token == null)
		response.sendRedirect("Login.jsp");
	else {
		String username = JWTUtil.getUsername(token);
		DAOImpl dao = DAOImpl.getInstance();
		ResultSet rs = dao.getOrders(username);
		System.out.println("My order:" +username);
	%>
	<div>
		<div class="mb-5">
			<h1>My Orders</h1>
		</div>
		<div>
			<table class="table">
				<thead class="text-center">
					<tr>
						<th scope="col">Product</th>
						<th scope="col">Quantity</th>
						<th scope="col">Price</th>
						<th scope="col">Purchased On</th>
					</tr>
				</thead>
				<tbody class="text-center">
					<%
					while (rs.next()) {
					%>
					<tr class="orow">
						<td><%=rs.getString(1)%></td>
						<td><%=rs.getInt(2)%></td>
						<td><%=rs.getInt(3)%></td>
						<td><%=rs.getDate(4)%></td>
						
						
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<%
	}
	%>

</body>
</html>