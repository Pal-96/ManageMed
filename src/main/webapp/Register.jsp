<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
</head>
<!-- <nav class="navbar navbar-expand-lg navbar-light w-100"
	style="border-bottom: 2px solid grey">
<div class="container">
	<a class="navbar-brand" href="Login.html"><img
		src="assets/images/pills-solid.svg" alt="" width="30" height="30">
		ManageMed</a>

	<div class="offcanvas offcanvas-start offcanvas-nav"
		style="width: 20rem">

		<div class="offcanvas-body pt-0 align-items-center">
			<ul class="navbar-nav mx-auto align-items-lg-center">
				<li class="nav-item"><a class="nav-link" href="#" role="button"
					aria-expanded="false">Manage Medicine</a></li>
				<li class="nav-item"><a class="nav-link" href="#" role="button"
					aria-expanded="false">Customer Sale</a></li>
				<li class="nav-item"><a class="nav-link" href="#" role="button"
					aria-expanded="false">View Stock</a></li>
				<li class="nav-item"><a class="nav-link" href="#" role="button"
					aria-expanded="false">About Us</a></li>
			</ul>
			<div class="mt-3 mt-lg-0 d-flex align-items-center">
				<a href="Login.jsp" class="btn btn-light mx-2">Login</a> <a
					href="Register.jsp" class="btn btn-primary">Create account</a>
			</div>
		</div>
	</div>
</div>
</nav> -->
<div>
	<body>
	<jsp:include page="nav-bar-before-login.html" />
		<div class="container container-login">
			<div class="row">
				<div class="col container-login">
					<img src="assets/images/Welcome2.jpg"
						class="img-fluid placement rounded float-left text-center welcomeimg"
						alt="Responsive image">
				</div>
				<div class="card shadow-sm col container-login mb-6">
					<div class="card-body">
						<div class="text-center">
							<a href="index.html"><img src="assets/images/pills-solid.svg"
								width="50" height="50" alt="brand" class="mb-3"></a>
							<h1 class="mb-1">Create Account</h1>

						</div>
						<div id="liveAlertPlaceholder"></div>
						<form action="register" method="post"
							class="needs-validation placement-register" novalidate="">
							<div class="mb-2">
								<label for="firstname" class="form-label"> First Name <span
									class="text-danger">*</span>
								</label> <input type="text" class="form-control" id="firstname"
									name="firstname" required>
								<div class="invalid-feedback">Please enter first name.</div>
							</div>
							<div class="mb-2">
								<label for="lastname" class="form-label"> Last Name <span
									class="text-danger">*</span>
								</label> <input type="text" class="form-control" id="lastname"
									name="lastname" required>
								<div class="invalid-feedback">Please enter last name.</div>
							</div>
							<div class="mb-2">
								<label for="username" class="form-label"> UserName <span
									class="text-danger">*</span>
								</label> <input type="text" class="form-control" id="username"
									name="username" required>
								<div class="invalid-feedback">Please enter user name.</div>
							</div>
							<div class="mb-2">
								<label for="formSignUpPassword" class="form-label">Password</label>
								<div class="password-field position-relative">
									<input type="password" class="form-control fakePassword"
										id="formSignUpPassword" name="password" required> <span><i
										class="bi bi-eye-slash passwordToggler"></i></span>
									<div class="invalid-feedback">Please enter password.</div>
								</div>
							</div>

							<div class="d-grid">
								<button class="btn btn-primary" type="submit" name="action" id="action"
								value="register">Sign Up</button>
							</div>
							<p class="mt-3 text-muted">Copyrights &copy;2024. Built by Sayantika Pal</p>
						</form>


					</div>
				</div>

				<div class="w-100"></div>
			</div>
		</div>
		<%
		if (session.getAttribute("signuperror") != null) {
			session.removeAttribute("signuperror");
		%>
		<script>
			const alertPlaceholder = document
					.getElementById('liveAlertPlaceholder')
			const wrapper = document.createElement('div')
			if (wrapper) {
				wrapper.innerHTML = [
						`<div class="alert alert-warning alert-dismissible" role="alert">`,
						`   <div>Error in user registration. Please try again</div>`,
						'   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
						'</div>' ].join('')

				alertPlaceholder.append(wrapper)
			}
		</script>
		<%
		}
		%>
	</body>
</div>
</html>