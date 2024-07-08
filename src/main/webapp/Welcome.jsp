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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>


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
			<section class="cmt-7">
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
										class="col-12 col-md-4 mb-3 aos-init aos-animate border border-info border-1 rounded-pill cpr-7 bg-light"
										data-aos="fade-up">

										<!-- Icon -->
										<div class="icon text-primary mb-2 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor" class="bi bi-search"
												viewBox="0 0 16 16">
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
										class="col-12 col-md-4 aos-init aos-animate border border-info bg-light border-1 rounded-pill"
										data-aos="fade-up" data-aos-delay="50">

										<!-- Icon -->
										<div class="icon text-primary mb-3 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor"
												class="bi bi-cart-check-fill" viewBox="0 0 16 16">
  <path
													d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m-1.646-7.646-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708.708" />
</svg>
										</div>

										<!-- Heading -->
										<h3>Manage your selections</h3>

										<!-- Text -->
										<p class="text-body-secondary mb-7">Personalize your
											health journey by easily adding essentials and managing your
											cart with the flexibility to adapt as your needs evolve.</p>

									</div>
									<div
										class="col-12 col-md-4 aos-init aos-animate border border-info bg-light border-1 rounded-pill"
										data-aos="fade-up" data-aos-delay="100">

										<!-- Icon -->
										<div class="icon text-primary mb-3 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor"
												class="bi bi-file-earmark-plus" viewBox="0 0 16 16">
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
											healthcare routine by securely uploading prescriptions
											online, ensuring seamless access to medications from
											anywhere.</p>

									</div>

								</div>
							</div>
						</div>
						<div class="carousel-item" data-bs-interval="4000">
							<div class="container text-center">
								<div class="row">
									<div
										class="col-12 col-md-4 aos-init aos-animate border border-info bg-light border-1 rounded-pill"
										data-aos="fade-up">

										<!-- Icon -->
										<div class="icon text-primary mb-4 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor" class="bi bi-bag-heart"
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
										class="col-12 col-md-4 aos-init aos-animate border border-info bg-light border-1 rounded-pill"
										data-aos="fade-up">

										<!-- Icon -->
										<div class="icon text-primary mb-4 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor" class="bi bi-chat-dots"
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
											insights, shaping a trusted environment where your voice
											helps us continually improve our services.</p>

									</div>
									<div
										class="col-12 col-md-4 mb-3 aos-init aos-animate border border-info bg-light border-1 rounded-pill cpr-7"
										data-aos="fade-up">

										<!-- Icon -->
										<div class="icon text-primary mb-2 mt-4">
											<svg xmlns="http://www.w3.org/2000/svg" width="40"
												height="40" fill="currentColor" class="bi bi-search"
												viewBox="0 0 16 16">
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
			<section class="cmt-7">
			<h1 class="display-3">
				<h3 class="display-4 text-center">Our Impact</h3>
			</h1>
			</section>

			<!-- <section class="py-8 py-md-11 border-bottom">
				<div class="container">
					<div class="row">
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up">

							Icon
							<div class="icon text-primary mb-4">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-plus-slash-minus"
									viewBox="0 0 16 16">
  <path
										d="m1.854 14.854 13-13a.5.5 0 0 0-.708-.708l-13 13a.5.5 0 0 0 .708.708M4 1a.5.5 0 0 1 .5.5v2h2a.5.5 0 0 1 0 1h-2v2a.5.5 0 0 1-1 0v-2h-2a.5.5 0 0 1 0-1h2v-2A.5.5 0 0 1 4 1m5 11a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5A.5.5 0 0 1 9 12" />
</svg>
							</div>

							Heading
							<h3>Manage medicine stock</h3>

							Text
							<p class="text-body-secondary mb-6 mb-md-0">Landkit is built
								to make your life easier. Variables, build tooling,
								documentation, and reusable components.</p>

						</div>
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up" data-aos-delay="50">

							Icon
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

							Heading
							<h3>Check stock balance</h3>

							Text
							<p class="text-body-secondary mb-6 mb-md-0">Designed with the
								latest design trends in mind. Landkit feels modern, minimal, and
								beautiful.</p>

						</div>
						<div class="col-12 col-md-4 aos-init aos-animate"
							data-aos="fade-up" data-aos-delay="100">

							Icon
							<div class="icon text-primary mb-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-cart-check-fill"
									viewBox="0 0 16 16">
  <path
										d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m-1.646-7.646-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708.708" />
</svg>
							</div>

							Heading
							<h3>Add or Delete from cart</h3>

							Text
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

							Icon
							<div class="icon text-primary mb-3">
								<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
									fill="currentColor" class="bi bi-list-check"
									viewBox="0 0 16 16">
  <path fill-rule="evenodd"
										d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5M3.854 2.146a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 1 1 .708-.708L2 3.293l1.146-1.147a.5.5 0 0 1 .708 0m0 4a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 1 1 .708-.708L2 7.293l1.146-1.147a.5.5 0 0 1 .708 0m0 4a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0l-.5-.5a.5.5 0 0 1 .708-.708l.146.147 1.146-1.147a.5.5 0 0 1 .708 0" />
</svg>
							</div>

							Heading
							<h3>Seamless checkout</h3>

							Text
							<p class="text-body-secondary mb-0">We've written extensive
								documentation for components and tools, so you never have to
								reverse engineer anything.</p>

						</div>
					</div>
					/ .row
				</div>
				/ .container
			</section> -->
			<jsp:include page="footer.html" />
	</body>

</html>