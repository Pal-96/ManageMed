<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./assets/css/custom.css"></link>
</head>
<body>
	<div class="carttitle">
		<h1>Checkout</h1>
		<div>
			<p class="lead text-muted">Please fill out below details.</p>
		</div>
	</div>
	<div class="cust-cont">
		<ul class="nav nav-pills" id="myTab" role="tablist">
			<li class="nav-item"><a class="nav-link active" id="tab1-tab"
				data-toggle="tab" href="#tab1" role="tab" aria-controls="tab1"
				aria-selected="true">Tab 1</a></li>
			<li class="nav-item"><a class="nav-link" id="tab2-tab"
				data-toggle="tab" href="paymentMethod.html" role="tab" aria-controls="tab2"
				aria-selected="false">Tab 2</a></li>
			<li class="nav-item"><a class="nav-link" id="tab3-tab"
				data-toggle="tab" href="#tab3" role="tab" aria-controls="tab3"
				aria-selected="false">Tab 3</a></li>
		</ul>
		<br/>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="tab1" role="tabpanel"
				aria-labelledby="tab1-tab">
				<jsp:include page="invoiceAddr.html" />
			</div>
			<div class="tab-pane fade" id="tab2" role="tabpanel"
				aria-labelledby="tab2-tab">
				<h3>Content for Tab 2</h3>
				<p>This is the content for tab 2.</p>
			</div>
			<div class="tab-pane fade" id="tab3" role="tabpanel"
				aria-labelledby="tab3-tab">
				<h3>Content for Tab 3</h3>
				<p>This is the content for tab 3.</p>
			</div>
		</div>
	</div>

</body>
</html>