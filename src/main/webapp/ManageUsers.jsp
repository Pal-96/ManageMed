<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.app.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.app.service.test"%>
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
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	String role = null;
	String token = test.getCookie(request);
	String cartcount = "0";
	if (token == null)
		response.sendRedirect("Login.jsp");

	else {
		DAOImpl dao = DAOImpl.getInstance();
		rs1 = dao.getUsers();
		rs2 = dao.getRoles();
	%>
	<div class="container">
		<div class="row">
			<div class="col text-end mb-4 mt-3">
				<button type="button" class="btn btn-outline-dark"
					data-bs-toggle="modal" data-bs-target="#addModel"
					data-bs-whatever="@mdo" onclick="addUser(this)">
					Add User
					<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
						fill="currentColor" class="bi bi-plus-circle-fill"
						viewBox="0 0 16 16"> <path
							d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z" />
									</svg>
				</button>
			</div>
		</div>
		<div class="row">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">First</th>
						<th scope="col">Last</th>
						<th scope="col">User name</th>
						<th scope="col">Role</th>
						<th scope="col">Edit</th>
						<th scope="col">Delete</th>
					</tr>
				</thead>
				<tbody>
					<%
					while (rs1.next()) {
					%>
					<tr class="tbrowuser">
						<td><%=rs1.getString(2)%></td>
						<td><%=rs1.getString(3)%></td>
						<td id="usertb"><%=rs1.getString(1)%></td>
						<td><%=rs1.getString(4)%></td>
						<td><button type="button" class="btn" data-bs-toggle="modal"
								data-bs-target="#addModel" data-bs-whatever="@mdo"
								data-fn="<%=rs1.getString(2)%>"
								data-ln="<%=rs1.getString(3)%>"
								data-un="<%=rs1.getString(1)%>"
								data-role="<%=rs1.getString(4)%>"
								data-pw="<%=rs1.getString(5)%>" data-action="edit"
								onclick="populateModal(this)">
								<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15"
									fill="#0d6efd" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path
										d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
  <path fill-rule="evenodd"
										d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
</svg>
							</button></td>
						<td>
							<button type=button class="btn" onclick="handleDeleteUser(this)"
								id="liveAlertBtn">
								<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15"
									fill="red" class="bi bi-trash" viewBox="0 0 16 16">
  <path
										d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
  <path
										d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
</svg>
							</button>
						</td>
					</tr>
					<%
					}
					%>

				</tbody>
			</table>

		</div>
	</div>
	<div class="modal fade" id="addModel" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Add User</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="register" method="post">
						<div class="dropdown text-end">
							<button class="btn btn-primary dropdown-toggle" type="button"
								id="roleDropdown" data-bs-toggle="dropdown"
								aria-expanded="false" required>Role</button>

							<ul class="dropdown-menu">
								<%
								while (rs2.next()) {
								%>
								<li><a class="dropdown-item" href="#"
									onclick="setRole(this)"><%=rs2.getString(2)%></a></li>
								<%
								}
								%>
							</ul>
						</div>
						<input type="hidden" id="selectedRole" name="selectedRole"
							required>
						<div class="mb-3">
							<label for="firstname" class="col-form-label">First Name</label>
							<input type="text" class="form-control" id="firstname"
								name="firstname" required>
						</div>
						<div class="mb-3">
							<label for="lastname" class="col-form-label">Last Name</label> <input
								type="text" class="form-control" id="lastname" name="lastname"
								required>
						</div>
						<div class="mb-3">
							<label for="username" class="col-form-label">User Name</label> <input
								type="text" class="form-control" id="username" name="username"
								required>
						</div>
						<input type="hidden" id="hid-username" name="username">
						<div>
							<label for="password" class="col-form-label">Password</label>
						</div>
						<div class="mb-3 d-flex">
							<input type="password" class="form-control" id="password"
								name="password" required>
							<button type="button" class="btn">
								<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
									fill="#0d6efd" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path
										d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
  <path fill-rule="evenodd"
										d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
</svg>
							</button>
						</div>

						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary" name="action"
								id="action" value="add">Submit</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<script src="./js/manageusers.js"></script>
	<%
	}
	%>


</body>
</html>