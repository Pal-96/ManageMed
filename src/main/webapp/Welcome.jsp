<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.app.service.test"%>
<%@ page import="com.app.security.*"%>
<%@ page import="com.app.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>

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
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
</script>
</head>
<body>
	<%
	InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties");
	Properties properties = new Properties();
	properties.load(input);
	String publicKey = properties.getProperty("email.publicKey");
	String token = test.getCookie(request);
	String username = null;
	String name = null;
	DAOImpl dao;
	if (token == null) {
	%>
	<jsp:include page="nav-bar-before-login.html" />
	<%
	} else {
	dao = DAOImpl.getInstance();
	username = JWTUtil.getUsername(token);
	ResultSet rs2 = dao.getUser(username);
	if (rs2.next()) {
		name = rs2.getString(1) + " " + rs2.getString(2);
	}
	%>
	<jsp:include page="navbar-after-login.html" />
	<%
	}
	%>
	<%
	dao = DAOImpl.getInstance();
	int customers = 0;
	int totalSales = 0;
	int product = 0;
	ResultSet rs = null;
	dao.Connection();
	rs = dao.custRpt();
	if (rs.next())
		customers = rs.getInt(1);
	rs = dao.totSalesRpt();
	if (rs.next())
		totalSales = rs.getInt(1);
	rs = dao.totProductRpt();
	if (rs.next()) {
		product = rs.getInt(1);
	}
	%>
	<div>
		<section class="pt-6 pt-md-11" id="section1">
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
							Find, shop and checkout with your medicines seamlessly</p>
					</div>
				</div>
			</div>
		</section>
		<section class="cmt-7" id="section2">
			<h1 class="display-3">
				<h3 class="display-4 text-center">What we deliver</h3>
			</h1>
			<div id="carouselExampleAutoplaying" class="carousel slide mt-5"
				data-bs-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active" data-bs-interval="4000">
						<div class="container text-center">
							<div class="row">
								<div
									class="col-12 col-md-4 mb-3 aos-init aos-animate border border-warning border-1 rounded-pill cpr-7 bg-light"
									data-aos="fade-up">

									<!-- Icon -->
									<div class="icon text-primary mb-2 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path
												d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
</svg>
									</div>
									<!-- Heading -->
									<h3>Find your suitable medicines</h3>
									<!-- Text -->
									<p class="text-body-secondary mb-7">Navigate our extensive
										catalog effortlessly to find the exact medicines you need,
										ensuring your health is always within reach.</p>
								</div>
								<div
									class="col-12 col-md-4 aos-init aos-animate border border-warning bg-light border-1 rounded-pill"
									data-aos="fade-up" data-aos-delay="50">

									<!-- Icon -->
									<div class="icon text-primary mb-3 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-cart-check-fill"
											viewBox="0 0 16 16">
  <path
												d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m-1.646-7.646-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708.708" />
</svg>
									</div>
									<!-- Heading -->
									<h3>Manage your selections</h3>
									<!-- Text -->
									<p class="text-body-secondary mb-7">Personalize your health
										journey by easily adding essentials and managing your cart
										with the flexibility to adapt as your needs evolve.</p>
								</div>
								<div
									class="col-12 col-md-4 aos-init aos-animate border border-warning bg-light border-1 rounded-pill"
									data-aos="fade-up" data-aos-delay="100">

									<!-- Icon -->
									<div class="icon text-primary mb-3 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-file-earmark-plus"
											viewBox="0 0 16 16">
  <path
												d="M8 6.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V11a.5.5 0 0 1-1 0V9.5H6a.5.5 0 0 1 0-1h1.5V7a.5.5 0 0 1 .5-.5" />
  <path
												d="M14 4.5V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5zm-3 0A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5z" />
</svg>
									</div>

									<!-- Heading -->
									<h3>Upload prescriptions online</h3>

									<!-- Text -->
									<p class="text-body-secondary mb-7">Simplify your
										healthcare routine by securely uploading prescriptions online,
										ensuring seamless access to medications from anywhere.</p>
								</div>
							</div>
						</div>
					</div>
					<div class="carousel-item" data-bs-interval="4000">
						<div class="container text-center">
							<div class="row">
								<div
									class="col-12 col-md-4 aos-init aos-animate border border-warning bg-light border-1 rounded-pill"
									data-aos="fade-up">

									<!-- Icon -->
									<div class="icon text-primary mb-4 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-bag-heart"
											viewBox="0 0 16 16">
  <path fill-rule="evenodd"
												d="M10.5 3.5a2.5 2.5 0 0 0-5 0V4h5zm1 0V4H15v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V4h3.5v-.5a3.5 3.5 0 1 1 7 0M14 14V5H2v9a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1M8 7.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132" />
</svg>
									</div>

									<!-- Heading -->
									<h3>Seamless order processing</h3>

									<!-- Text -->
									<p class="text-body-secondary mb-7">Experience hassle-free
										ordering with streamlined processes that ensure your
										medications are delivered swiftly and reliably, every time.</p>
								</div>
								<div
									class="col-12 col-md-4 aos-init aos-animate border border-warning bg-light border-1 rounded-pill"
									data-aos="fade-up">

									<!-- Icon -->
									<div class="icon text-primary mb-4 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-chat-dots"
											viewBox="0 0 16 16">
  <path
												d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
  <path
												d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9 9 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.4 10.4 0 0 1-.524 2.318l-.003.011a11 11 0 0 1-.244.637c-.079.186.074.394.273.362a22 22 0 0 0 .693-.125m.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6-3.004 6-7 6a8 8 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a11 11 0 0 0 .398-2" />
</svg>
									</div>

									<!-- Heading -->
									<h3>Share candid feedbacks</h3>

									<!-- Text -->
									<p class="text-body-secondary mb-7">Sharing your valuable
										insights, shaping a trusted environment where your voice helps
										us continually improve our services.</p>

								</div>
								<div
									class="col-12 col-md-4 mb-3 aos-init aos-animate border border-warning bg-light border-1 rounded-pill cpr-7"
									data-aos="fade-up">

									<!-- Icon -->
									<div class="icon text-primary mb-2 mt-4">
										<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
											fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path
												d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
</svg>
									</div>

									<!-- Heading -->
									<h3>Find your suitable medicines</h3>

									<!-- Text -->
									<p class="text-body-secondary mb-7">Navigate our extensive
										catalog effortlessly to find the exact medicines you need,
										ensuring your health is always within reach.</p>

								</div>


							</div>

							<!-- / .row -->
						</div>
					</div>


				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="carouselExampleAutoplaying" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="carouselExampleAutoplaying" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</section>
		<section class="cmt-7" id="section3">
			<h1 class="display-3">
				<h3 class="display-4 text-center">Our Impact</h3>
			</h1>
			<section class="py-0 py-xl-5">
				<div class="container">
					<div class="row g-3 justify-content-center">
						<!-- Counter item -->
						<div class="col-sm-6 col-xl-3" id="activeusers">
							<div
								class="d-flex justify-content-center align-items-center p-4 bg-warning border border-info bg-opacity-20 rounded-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-people-fill"
									viewBox="0 0 16 16">
  <path
										d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5" />
</svg>
								<div class="ms-4 h6 fw-normal mb-0">
									<div class="d-flex">
										<h5 class="purecounter mb-0 fw-bold"
											data-purecounter-start="0" data-purecounter-end="10"
											data-purecounter-delay="200" data-purecounter-duration="0"><%=customers%></h5>
										<span class="mb-0 h5">+</span>
									</div>
									<p class="mb-0">Active Users</p>
								</div>
							</div>
						</div>
						<!-- Counter item -->
						<div class="col-sm-6 col-xl-3" id="totalsales">
							<div
								class="d-flex justify-content-center align-items-center p-4 bg-warning border border-info bg-opacity-20 rounded-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-receipt" viewBox="0 0 16 16">
  <path
										d="M1.92.506a.5.5 0 0 1 .434.14L3 1.293l.646-.647a.5.5 0 0 1 .708 0L5 1.293l.646-.647a.5.5 0 0 1 .708 0L7 1.293l.646-.647a.5.5 0 0 1 .708 0L9 1.293l.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .801.13l.5 1A.5.5 0 0 1 15 2v12a.5.5 0 0 1-.053.224l-.5 1a.5.5 0 0 1-.8.13L13 14.707l-.646.647a.5.5 0 0 1-.708 0L11 14.707l-.646.647a.5.5 0 0 1-.708 0L9 14.707l-.646.647a.5.5 0 0 1-.708 0L7 14.707l-.646.647a.5.5 0 0 1-.708 0L5 14.707l-.646.647a.5.5 0 0 1-.708 0L3 14.707l-.646.647a.5.5 0 0 1-.801-.13l-.5-1A.5.5 0 0 1 1 14V2a.5.5 0 0 1 .053-.224l.5-1a.5.5 0 0 1 .367-.27m.217 1.338L2 2.118v11.764l.137.274.51-.51a.5.5 0 0 1 .707 0l.646.647.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.646.646.646-.646a.5.5 0 0 1 .708 0l.509.509.137-.274V2.118l-.137-.274-.51.51a.5.5 0 0 1-.707 0L12 1.707l-.646.647a.5.5 0 0 1-.708 0L10 1.707l-.646.647a.5.5 0 0 1-.708 0L8 1.707l-.646.647a.5.5 0 0 1-.708 0L6 1.707l-.646.647a.5.5 0 0 1-.708 0L4 1.707l-.646.647a.5.5 0 0 1-.708 0z" />
  <path
										d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m8-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5" />
</svg>
								<div class="ms-4 h6 fw-normal mb-0">
									<div class="d-flex">
										<h5 class="purecounter mb-0 fw-bold"
											data-purecounter-start="0" data-purecounter-end="200"
											data-purecounter-delay="200" data-purecounter-duration="0"><%=totalSales%></h5>
										<span class="mb-0 h5">+</span>
									</div>
									<p class="mb-0">Total Sales</p>
								</div>
							</div>
						</div>
						<!-- Counter item -->
						<div class="col-sm-6 col-xl-3" id="products">
							<div
								class="d-flex justify-content-center align-items-center p-4 bg-warning border border-info bg-opacity-20 rounded-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-boxes" viewBox="0 0 16 16">
  <path
										d="M7.752.066a.5.5 0 0 1 .496 0l3.75 2.143a.5.5 0 0 1 .252.434v3.995l3.498 2A.5.5 0 0 1 16 9.07v4.286a.5.5 0 0 1-.252.434l-3.75 2.143a.5.5 0 0 1-.496 0l-3.502-2-3.502 2.001a.5.5 0 0 1-.496 0l-3.75-2.143A.5.5 0 0 1 0 13.357V9.071a.5.5 0 0 1 .252-.434L3.75 6.638V2.643a.5.5 0 0 1 .252-.434zM4.25 7.504 1.508 9.071l2.742 1.567 2.742-1.567zM7.5 9.933l-2.75 1.571v3.134l2.75-1.571zm1 3.134 2.75 1.571v-3.134L8.5 9.933zm.508-3.996 2.742 1.567 2.742-1.567-2.742-1.567zm2.242-2.433V3.504L8.5 5.076V8.21zM7.5 8.21V5.076L4.75 3.504v3.134zM5.258 2.643 8 4.21l2.742-1.567L8 1.076zM15 9.933l-2.75 1.571v3.134L15 13.067zM3.75 14.638v-3.134L1 9.933v3.134z" />
</svg>
								<div class="ms-4 h6 fw-normal mb-0">
									<div class="d-flex">
										<h5 class="purecounter mb-0 fw-bold"
											data-purecounter-start="0" data-purecounter-end="60"
											data-purecounter-delay="200" data-purecounter-duration="0"><%=product%></h5>
										<span class="mb-0 h5">+</span>
									</div>
									<p class="mb-0">Products</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</section>
		<section class="cmt-7 mt-5 pl-5 pr-5 border rounded bg-feedback"
			id="section4">
			<h1 class="display-3">
				<h3 class="display-4 text-center">Share your thoughts</h3>
			</h1>
			<section class="mt-3">
				<form class="needs-validation was-validated" novalidate>
					<div class="mb-3">
						<label for="feedback" class="form-label">Feedback</label>
						<textarea class="form-control" id="feedback"
							placeholder="Share your thoughts" name="feedback" required></textarea>
						<div class="invalid-feedback">Please enter a message in the
							text area.</div>
					</div>
					<div class="position-relative">
						<label for="email" class="form-label">Email</label> <input
							type="email" class="form-control" id="email"
							placeholder="Enter your email" name="cust-email" required>
						<div class="valid-tooltip">Looks good!</div>
					</div>
					<input id="name" name="name" value="<%=name%>" hidden="true">
					<div class="col-12 mb-5 mt-4">
						<button class="btn btn-primary" onclick="sendEmail()"
							type="submit">
							Send
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-send-check" viewBox="0 0 16 16">
  <path
									d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855a.75.75 0 0 0-.124 1.329l4.995 3.178 1.531 2.406a.5.5 0 0 0 .844-.536L6.637 10.07l7.494-7.494-1.895 4.738a.5.5 0 1 0 .928.372zm-2.54 1.183L5.93 9.363 1.591 6.602z" />
  <path
									d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0m-1.993-1.679a.5.5 0 0 0-.686.172l-1.17 1.95-.547-.547a.5.5 0 0 0-.708.708l.774.773a.75.75 0 0 0 1.174-.144l1.335-2.226a.5.5 0 0 0-.172-.686" />
</svg>
						</button>
					</div>
				</form>
			</section>
		</section>
		<script type="text/javascript">
   (function(){
      emailjs.init({
        publicKey: "<%=publicKey%>",
				});
			})();
		</script>
		<script src="./js/email.js"></script>
		<jsp:include page="footer.html" />
		<script src="./js/script.js"></script>
</body>
</html>