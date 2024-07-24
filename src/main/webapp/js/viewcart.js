localStorage.removeItem("timeout_id");
function handleRemoveCart(button) {
	let item = button.closest('.item-of-cart');
	let product = item.querySelector('.product').innerText;
	console.log(product);
	let removecart = "REMOVE";
	let response = fetch('addtocart', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: new URLSearchParams({
			product: product,
			removecart: removecart

		})

	}).then(response => {
		if (response.ok) {
			location.reload();  // Refresh the page
		} else {
			console.error('Failed to remove item from cart');
		}
	}).catch(error => {
		console.error('Error:', error);
	});

}

function updateDropdown(element) {
	console.log(element.textContent);
	let dropdownButton = element.closest('.quantity');
	let div = element.closest('.d-flex');
	let quan = dropdownButton.querySelector('.dropdown-toggle');
	let newQuantity = element.textContent;
	quan.textContent = newQuantity;
	let product = div.querySelector('.product').innerText;
	let addtocart = "addtocart";
	let response = fetch('addtocart', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: new URLSearchParams({
			product: product,
			cartquan: newQuantity,
			addtocart: addtocart

		})
	}).then(response => {
		if (response.ok) {
			location.reload();  // Refresh the page
		} else {
			console.error('Failed to increase item quantity');
		}
	}).catch(error => {
		console.error('Error:', error);
	});

	// Here you can also send the updated quantity to the server if needed
}

function handleCheckOut() {
	console.log("Inside handle checkout");
	let timeout_id = setTimeout(function() {
                // After 1 minutes, check the payment status
                if (parseInt(localStorage.getItem("timeout_id"),10))
                {
					checkPaymentStatus();	
				}
            }, 60000); // 5 minutes in milliseconds
	console.log(timeout_id);
	localStorage.setItem("timeout_id",timeout_id);
}

function checkPaymentStatus() {
	console.log("Inside check payment status");
	fetch('checkpaymentstatus')
	.then(window.open('PaymentError.jsp', '_blank'));
	localStorage.removeItem("timeout_id");
}

function handleCancel() {
	let timeout_id = parseInt(localStorage.getItem("timeout_id"),10);
	console.log(timeout_id);
	clearTimeout(timeout_id);
	localStorage.removeItem("timeout_id");
}