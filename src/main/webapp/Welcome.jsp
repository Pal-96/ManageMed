<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
</head>
<center>

	<body>
		<%
		String token = test.getCookie(request);
		if (token == null) {
		%>
		<jsp:include page="nav-bar-before-login.html" />
		<%
		} else {
		%>
		<jsp:include page="navbar-after-login.html" />
		<%
		}
		%>
		<div>

			<section class="pt-6 pt-md-11">
				<br /> <br /> <br />
				<div class="container">
					<div class="row align-items-center">
						<div class="col-12 col-md-5 col-lg-6 order-md-2">

							<!-- Image -->
							<img src="assets/images/Home.jpg"
								class="img-fluid mw-md-150 mw-lg-130 mb-6 mb-md-0 aos-init aos-animate rounded"
								alt="..." data-aos="fade-up" data-aos-delay="100">

						</div>
						<div
							class="col-12 col-md-7 col-lg-6 order-md-1 aos-init aos-animate"
							data-aos="fade-up">

							<!-- Heading -->
							<h1 class="display-3 text-center text-md-center">
								Welcome to <span class="text-primary">ManageMed</span><br>
								<h3 class="display-4 text-center text-md-center">Pharmacy
									assistant.</h3>
							</h1>

							<!-- Text -->
							<p
								class="lead text-center text-md-center text-body-secondary mb-6 mb-lg-8">
								Organize, manage, sell medicines seamlessly</p>



						</div>
					</div>
					<!-- / .row -->
				</div>
				<!-- / .container -->
			</section>
			<br /> <br /> <br /> <br /> <br />
			<section class="py-8 py-md-11 border-bottom">
				<div class="container">
					<div class="row">
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up">

							<!-- Icon -->
							<div class="icon text-primary mb-4">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-plus-slash-minus"
									viewBox="0 0 16 16">
  <path
										d="m1.854 14.854 13-13a.5.5 0 0 0-.708-.708l-13 13a.5.5 0 0 0 .708.708M4 1a.5.5 0 0 1 .5.5v2h2a.5.5 0 0 1 0 1h-2v2a.5.5 0 0 1-1 0v-2h-2a.5.5 0 0 1 0-1h2v-2A.5.5 0 0 1 4 1m5 11a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5A.5.5 0 0 1 9 12" />
</svg>
							</div>

							<!-- Heading -->
							<h3>Manage medicine stock</h3>

							<!-- Text -->
							<p class="text-body-secondary mb-6 mb-md-0">Landkit is built
								to make your life easier. Variables, build tooling,
								documentation, and reusable components.</p>

						</div>
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up" data-aos-delay="50">

							<!-- Icon -->
							<div class="icon text-primary mb-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-clipboard2-check"
									viewBox="0 0 16 16">
  <path
										d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5z" />
  <path
										d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5z" />
  <path
										d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0z" />
</svg>
							</div>

							<!-- Heading -->
							<h3>Check stock balance</h3>

							<!-- Text -->
							<p class="text-body-secondary mb-6 mb-md-0">Designed with the
								latest design trends in mind. Landkit feels modern, minimal, and
								beautiful.</p>

						</div>
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up" data-aos-delay="100">

							<!-- Icon -->
							<div class="icon text-primary mb-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-cart-check-fill"
									viewBox="0 0 16 16">
  <path
										d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m-1.646-7.646-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708.708" />
</svg>
							</div>

							<!-- Heading -->
							<h3>Add or Delete from cart</h3>

							<!-- Text -->
							<p class="text-body-secondary mb-0">We've written extensive
								documentation for components and tools, so you never have to
								reverse engineer anything.</p>

						</div>

					</div>
					<br />
					<div
						class="row d-flex justify-content-center align-items-center mb-5">
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up" data-aos-delay="100">

							<!-- Icon -->
							<div class="icon text-primary mb-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-list-check"
									viewBox="0 0 16 16">
  <path fill-rule="evenodd"
										d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3.854 2.146a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 1 1 .708-.708L2 3.293l1.146-1.147a.5.5 0 0 1 .708 0m0 4a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 1 1 .708-.708L2 7.293l1.146-1.147a.5.5 0 0 1 .708 0m0 4a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 0 1 .708-.708l.146.147 1.146-1.147a.5.5 0 0 1 .708 0" />
</svg>
							</div>

							<!-- Heading -->
							<h3>Seamless checkout</h3>

							<!-- Text -->
							<p class="text-body-secondary mb-0">We've written extensive
								documentation for components and tools, so you never have to
								reverse engineer anything.</p>

						</div>
					</div>
					<!-- / .row -->
				</div>
				<!-- / .container -->
			</section>
	</body>
</center>
</html>