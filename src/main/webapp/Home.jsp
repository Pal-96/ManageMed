<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.app.service.test"%>
<%@ page import="com.app.security.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
<div style="color: black">
	<body>
		<center>
			<%
			String token = test.getCookie(request);
			String username = null;
			if (token == null)
				response.sendRedirect("Login.jsp");
			else {
				username = JWTUtil.getUsername(token);
			%>
			<jsp:include page="navbar-after-login.html" />
			<%
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
		</center>
		<section class="py-lg-7 py-5 bg-light-subtle">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-4">
					<div
						class="d-flex align-items-center mb-4 justify-content-center justify-content-md-start">
						<svg xmlns="http://www.w3.org/2000/svg" width="23" height="23"
							fill="currentColor" class="bi bi-person-circle"
							viewBox="0 0 16 16"> <path
							d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" /> <path
							fill-rule="evenodd"
							d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
						</svg>
						<div class="ms-3">
							<h5 class="mb-0"><%= username%></h5>
							<small>Personal account</small>
						</div>
					</div>
					<div class="d-md-none text-center d-grid">
						<button
							class="btn btn-light mb-3 d-flex align-items-center justify-content-between"
							type="button" data-bs-toggle="collapse"
							data-bs-target="#collapseAccountMenu" aria-expanded="false"
							aria-controls="collapseAccountMenu">
							Account Menu <i class="bi bi-chevron-down ms-2"></i>
						</button>
					</div>
					<div class="collapse d-md-block" id="collapseAccountMenu">
						<ul class="nav flex-column nav-account">
							<li class="nav-item"><a class="nav-link"
								href="javascript:void(0);"
								onclick="loadContent('DisplayAll.jsp')"> <i
									class="align-bottom bx bx-home"></i> <span class="ms-2">Dashboard</span></a></li>
							<li class="nav-item"><a class="nav-link"
								href="javascript:void(0);" onclick="loadContent('ViewCart.jsp')">
									<i class="align-bottom bx bx-user"></i> <span class="ms-2">View
										Cart</span>
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="javascript:void(0);"
								onclick="loadContent('ViewStock.jsp')"> <i
									class="align-bottom bx bx-user"></i> <span class="ms-2">Stock
										Balance</span></a></li>
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="javascript:void(0);"
								onclick="loadContent('CustomerSale.jsp')"> <i
									class="align-bottom bx bx-lock-alt"></i> <span class="ms-2">Customer
										Sale</span></a></li>
							<li class="nav-item"><a class="nav-link"
								href="javascript:void(0);" onclick="loadContent('Bill.jsp')">
									<i class="align-bottom bx bx-credit-card-front"></i> <span
									class="ms-2">Generate Bill</span>
							</a></li>
						</ul>
					</div>
				</div>
				<!-- <main class="main bg-dark">
    <iframe id="contentFrame" class="iframe-preview" width="100%" height="600px" src=""></iframe>
</main> -->
				<div class="col-lg-9 col-md-8">
					<div class="container">
						<div class="row">
							<div class="col text-start">
								<button type="button" class="btn btn-outline-dark"
									data-bs-toggle="modal" data-bs-target="#exampleModal"
									data-bs-whatever="@mdo">
									New Item
									<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
										fill="currentColor" class="bi bi-plus-circle-fill"
										viewBox="0 0 16 16"> <path
										d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z" />
									</svg>
								</button>
							</div>
							<div class="col text-end">
								<form action="DisplayAll.jsp" method="post"
									class="input-group mb-3" target="myIframe">
									<input type="text" class="form-control" name="product"
										placeholder="Search Medicine" aria-label="Search Medicine"
										aria-describedby="button-addon2">
									<button class="btn btn-outline-dark" type="submit"
										id="button-addon2">
										<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
											fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
										<path
											d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
										</svg>
									</button>
								</form>
							</div>
						</div>
					</div>
					<br /> <br />
					<iframe id="contentFrame" name="myIframe" class="iframe-preview"
						width="100%" height="600px" src="DisplayAll.jsp"></iframe>
					<!-- <iframe id="contentFrame" width="100%" height="600px" style="border:none;"></iframe> -->
				</div>
			</div>
		</div>
		</section>
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">New
							message</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="addrem" method="post">
							<div class="mb-3">
								<label for="product" class="col-form-label">Product</label> <input
									type="text" class="form-control" id="product" name="product">
							</div>
							<div class="mb-3">
								<label for="description" class="col-form-label">Description</label>
								<textarea class="form-control" id="description"></textarea>
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
											Price</label> <input type="text" class="form-control" id="unitprice"
											name="unitprice">
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary" name="action"
									value="add">Add</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>

		<form action="logout" method="post">
			<input style="cursor: pointer" type="Submit" value="Logout">
		</form>

		<script>
			function loadContent(page) {
				document.getElementById('contentFrame').src = page;
			}
		</script>

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ppJrBfQZ6Nx69ul5kxDwepP6ct3U7y5rVZHZB4Xtmbw8H6hoF+jNQaIfFAl3sHUt"
			crossorigin="anonymous"></script>
	</body>
</div>




</html>