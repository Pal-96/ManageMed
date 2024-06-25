<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.app.dao.*"%>
<%@ page import="java.sql.*"%>
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
	if (session.getAttribute("username") == null) {
		response.sendRedirect("Login.jsp");
	}

	else {
		DAOImpl dao = DAOImpl.getInstance();
		ResultSet rs = dao.displayAll();
	%>

	<div class="row">

		<%
		while (rs.next()) {
		%>
		<div class="col-sm-6 mb-3 mb-sm-0">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title"><%=rs.getString(1)%></h5>
					<p class="card-text">With supporting text below as a natural
						lead-in to additional content.</p>
					<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						<!-- Button trigger modal -->
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal"
							data-bs-whatever="@mdo">Add</button>
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal"
							data-bs-whatever="@fat">Delete</button>

						<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">New
											message</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form action="addrem" method="post">
											<div class="mb-3">
												<label for="product" class="col-form-label">Product</label>
												<input type="text" class="form-control" id="product"
													name="product">
											</div>
											<div class="mb-3">
												<label for="description" class="col-form-label">Description</label>
												<textarea class="form-control" id="description"></textarea>
											</div>

											<div>
												<label for="Qty" class="col-form-label">Quantity</label> <input
													name="items" type="number" class="btn-quan" name="quantity"
													value="1">
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>
												<button type="submit" class="btn btn-primary" name="action" value="add">Add</button>
											</div>
										</form>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<br />
		</div>

		<%
		}
		}
		%>
	</div>

</body>
</html>