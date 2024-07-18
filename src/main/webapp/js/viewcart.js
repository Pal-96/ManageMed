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