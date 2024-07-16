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
						<h1 class="mb-1">Welcome Back</h1>
						<p>
							Don't have an account yet? <a href="Register.jsp"
								class="text-primary">Register here</a>
						</p>
						


					</div>
					<div id="liveAlertPlaceholder"></div>
					<form action="test" method="POST"
						class="needs-validation placement-login" novalidate="">
						<div class="mb-4">
							<label for="username" class="form-label"> Username <span
								class="text-danger">*</span>
							</label> <input type="text" class="form-control" name="username"
								id="username" required="">
							<div class="invalid-feedback">Please enter username.</div>
						</div>
						<div class="mb-3">
							<label for="formSignUpPassword" class="form-label">Password</label>
							<div class="password-field position-relative">
								<input type="password" class="form-control fakePassword"
									name="password" id="formSignUpPassword" required=""> <span><i
									class="bi bi-eye-slash passwordToggler"></i></span>
								<div class="invalid-feedback">Please enter password.</div>
							</div>
						</div>

						<div class="d-grid">
							<button class="btn btn-primary" type="submit">Sign In</button>
						</div>
						<p class="mt-3 text-muted">Copyrights &copy;2024. Built by Sayantika Pal</p>
					</form>


				</div>
			</div>

			<div class="w-100"></div>
		</div>
	</div>
	<%
	if (session.getAttribute("invalidcreds")!=null) {
		out.println("Invalid credentials");
		session.removeAttribute("invalidcreds");
	%>
	<script>
		const alertPlaceholder = document
				.getElementById('liveAlertPlaceholder')
			const wrapper = document.createElement('div')
			if (wrapper) {
				wrapper.innerHTML = [
						`<div class="alert alert-warning alert-dismissible" role="alert">`,
						`   <div>Invalid credentials</div>`,
						'   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
						'</div>' ].join('')

				alertPlaceholder.append(wrapper)
			}
	</script>
	<%
	}
	%>
</body>
</center>
</html>