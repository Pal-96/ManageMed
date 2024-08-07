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
	ResultSet rs = null;
	String role = null;
	String token = test.getCookie(request);
	String cartcount = "0";
	if (token == null)
		response.sendRedirect("Login.jsp");

	else {
		role = JWTUtil.getRole(token);
		DAOImpl dao;
		String product = request.getParameter("product");
		String deletestock = request.getParameter("deletestock");
		System.out.println("Product: " + product);
		String action = (String) session.getAttribute("action");
		if (product == null || product == "" || action == "deletestock") {
			dao = DAOImpl.getInstance();
			rs = dao.displayAll();
		} else {
			dao = DAOImpl.getInstance();
			rs = dao.display(product);
		}

		String med = "" + session.getAttribute("med");
		String quantity = "" + session.getAttribute("quan");
		cartcount = "" + session.getAttribute("cartcount");
	%>
	<div id="liveAlertPlaceholder"></div>
	<div class="row row-cols-3 g-4">

		<%
		while (rs.next()) {
		%>
		<div class="col">
			<div class="card text-bg-light">
			<%if (role.equals("Customer")) {%>
				<div class="card-header">
					<div class="container text-end">

						<div>
							<button type="button" class="btn btn-primary" id="liveAlertBtn"
								onclick="handleAddtoCart(this)">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
									fill="currentColor" class="bi bi-cart-plus-fill"
									viewBox="0 0 16 16">
  <path
										d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0M9 5.5V7h1.5a.5.5 0 0 1 0 1H9v1.5a.5.5 0 0 1-1 0V8H6.5a.5.5 0 0 1 0-1H8V5.5a.5.5 0 0 1 1 0" />
</svg>
								Add
							</button>
						</div>

					</div>
				</div>
				<%} %>
				<img src="assets/images/products.png" class="card-img-top" height="250px" alt="...">
				<div class="card-body">

					<h5 class="card-title"><%=rs.getString(1)%></h5>
					<p class="card-text"><%=rs.getString(4)%></p>
					<ul class="list-group list-group-flush">
						<li class="list-group-item text-bg-light">Quantity: <%=rs.getString(2)%></li>
						<li class="list-group-item text-bg-light">Unit Price: $<%=rs.getString(3)%></li>
					</ul>
				</div>
				<%if (role.equals("Admin")) { %>
				<div class="card-footer text-body-secondary text-end">
					<div class="d-flex">
						<div>
							<button type="button" class="btn" data-bs-toggle="modal"
								data-bs-target="#exampleModal" data-bs-whatever="@mdo"
								data-product="<%=rs.getString(1)%>"
								data-description="<%=rs.getString(4)%>"
								data-quantity="<%=rs.getString(2)%>"
								data-unitprice="<%=rs.getString(3)%>" data-action="edit"
								onclick="populateModal(this)">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
									fill="#0d6efd" class="bi bi-pencil-square"
									viewBox="0 0 16 16">
  <path
										d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
  <path fill-rule="evenodd"
										d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
</svg>
							</button>
						</div>
						<div>

							<button type=button class="btn" onclick="handleDeleteStock(this)"
								id="liveAlertBtn">
								<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
									fill="red" class="bi bi-trash" viewBox="0 0 16 16">
  <path
										d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z" />
  <path
										d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z" />
</svg>
							</button>

						</div>
					</div>
				</div>
				<%} %>
			</div>
			<br />
		</div>

		<%
		}
		}
		%>
	</div>
	<div class="modal fade" id="exampleModal" tabindex="-1"
							aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h1 class="modal-title fs-5" id="exampleModalLabel">Edit Item</h1>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<form action="addrem" method="post">
											<div class="mb-3">
												<label for="product" class="col-form-label">Product</label>
												<input type="text" class="form-control" disabled="disabled" id="product">
												<input type="hidden" id="hiddenproduct" name="product">	
											</div>
											<div class="mb-3">
												<label for="description" class="col-form-label">Description</label>
												<textarea class="form-control" id="description" name="description"></textarea>
											</div>

											<div class="container mb-3">
												<div class="row">
													<div class="col-md-6">
														<label for="quantity" class="col-form-label">Quantity</label>
														<input type="text" class="form-control" id="quantity"
															name="quantity">
													</div>
													<div class="col-md-6">
														<label for="unitprice" class="col-form-label">Unit
															Price</label> <input type="text" class="form-control"
															id="unitprice" name="unitprice">
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Close</button>
												<button type="submit" class="btn btn-primary" name="action"
													value="edit">Submit</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
	<script src="./js/displayall.js"></script>
	<%
	if (session.getAttribute("productexists") != null) {
		System.out.println("Inside home:"+session.getAttribute("productexists"));
		session.removeAttribute("productexists");
	%>
	<script src="./js/home.js"></script>
	<%
	}
	%>
</body>
</html>