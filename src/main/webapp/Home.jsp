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

<body>
	<%
	String token = test.getCookie(request);

	if (token == null)
		response.sendRedirect("Login.jsp");

	else {
		String username = JWTUtil.getUsername(token);;
		String role = JWTUtil.getRole(token);
		System.out.println(role);
	%>
	<jsp:include page="navbar-after-login.html" />
	<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
	
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<button class="btn btn-primary" type="button"
					data-bs-toggle="offcanvas"
					data-bs-target="#offcanvasWithBothOptions"
					aria-controls="offcanvasWithBothOptions">
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
						fill="currentColor" class="bi bi-menu-button-wide-fill"
						viewBox="0 0 16 16"> <path
						d="M1.5 0A1.5 1.5 0 0 0 0 1.5v2A1.5 1.5 0 0 0 1.5 5h13A1.5 1.5 0 0 0 16 3.5v-2A1.5 1.5 0 0 0 14.5 0zm1 2h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m9.927.427A.25.25 0 0 1 12.604 2h.792a.25.25 0 0 1 .177.427l-.396.396a.25.25 0 0 1-.354 0zM0 8a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm1 3v2a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2zm14-1V8a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v2zM2 8.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0 4a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5" />
					</svg>
					Menu
				</button>
			</div>
			<div class="col d-flex">
				<%if (role.equals("Admin")) {%>
				<div class="col text-end cpr-7">
					<button type="button" class="btn btn-outline-dark"
						data-bs-toggle="modal" data-bs-target="#addModel"
						data-bs-whatever="@mdo">
						New Item
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
							fill="currentColor" class="bi bi-plus-circle-fill"
							viewBox="0 0 16 16"> <path
							d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z" />
						</svg>
					</button>
				</div>
				<%
				}
				%>
				<div class="col text-end search">
					<form id="searchForm" action="DisplayAll.jsp" method="post"
						class="input-group mb-3" target="myIframe">
						<input type="text" class="form-control border-dark" name="product"
							placeholder="Search Product" aria-label="Search Medicine"
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
	</div>
	<div class="offcanvas offcanvas-start" data-bs-scroll="true"
		tabindex="-1" id="offcanvasWithBothOptions"
		aria-labelledby="offcanvasWithBothOptionsLabel">
		<div class="offcanvas-header">
			<div
				class="d-flex align-items-center mb-4 justify-content-center justify-content-md-start">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
					fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" /> <path
					fill-rule="evenodd"
					d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
				</svg>
				<div class="ms-3">
					<h5 class="mb-0"><%=username%></h5>
					<%
					if (role.equals("Admin")) {
					%>
					<small>Application Admin</small>
					<%
					} else if (role.equals("Customer")) {
					%>
					<small>Personal account</small>
					<%
					}
					%>
				</div>
			</div>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<div class="collapse d-md-block" id="collapseAccountMenu">
				<ul class="nav flex-column nav-account">
					<%if (role.equals("Admin")) {%>
					<li class="nav-item bg-light border rounded-pill"><a
						class="nav-link" href="javascript:void(0);"
						onclick="loadContent('DisplayAll.jsp')"> <i
							class="align-bottom bx bx-home"></i> <span class="ms-2">Manage
								Stock</span></a></li>
					<li></li>
					<li class="nav-item bg-light border rounded-pill"><a
						class="nav-link" href="javascript:void(0);"
						onclick="loadContent('ManageRoles.jsp')"> <i
							class="align-bottom bx bx-user"></i> <span class="ms-2">Manage
								Role</span>
					</a></li>
					<li class="nav-item bg-light border rounded-pill"><a
						class="nav-link" href="javascript:void(0);"
						onclick="loadContent('ManageUsers.jsp')"> <i
							class="align-bottom bx bx-user"></i> <span class="ms-2">Manage
								Users</span>
					</a></li>
					<%
					} else if (role.equals("Customer")) {
					%>
					<li class="nav-item bg-light border rounded-pill"><a
						class="nav-link" href="javascript:void(0);"
						onclick="loadContent('DisplayAll.jsp')"> <i
							class="align-bottom bx bx-home"></i> <span class="ms-2">Dashboard</span></a></li>
					<li class="nav-item bg-light border rounded-pill"><a
						class="nav-link" href="javascript:void(0);"
						onclick="loadContent('ViewCart.jsp')"> <i
							class="align-bottom bx bx-user"></i> <span class="ms-2">View
								Cart</span>
					</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</div>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<iframe id="contentFrame" name="myIframe" class="iframe-preview"
					width="100%" height="600px" src="DisplayAll.jsp"></iframe>
			</div>
		</div>
	</div>
	
	<div class="mt-5"></div>
	<div class="modal fade" id="addModel" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Add Item</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="addrem" method="post" target="myIframe">
						<div class="mb-3">
							<label for="product" class="col-form-label">Product</label> <input
								type="text" class="form-control" id="product" name="product">
						</div>
						<div class="mb-3">
							<label for="description" class="col-form-label">Description</label>
							<textarea class="form-control" id="description"
								name="description"></textarea>
						</div>
						<div class="container mb-3">
							<div class="row">
								<div class="col-md-6">
									<label for="quantity" class="col-form-label">Quantity</label> <input
										type="text" class="form-control" id="quantity" name="quantity">
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

	<jsp:include page="footer.html" />

	<script>
		function loadContent(page) {
			document.getElementById('contentFrame').src = page;
			document.getElementById('searchForm').action = page;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ppJrBfQZ6Nx69ul5kxDwepP6ct3U7y5rVZHZB4Xtmbw8H6hoF+jNQaIfFAl3sHUt"
		crossorigin="anonymous"></script>

	<%
	}
	%>
</body>





</html>