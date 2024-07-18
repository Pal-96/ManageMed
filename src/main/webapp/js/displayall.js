function handleAddtoCart(button) {

	let card = button.closest('.card');
	let title = card.querySelector('.card-title').innerText;
	let cartquan = 1;
	let addtocart = "addtocart";

	let response = fetch('addtocart', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: new URLSearchParams({
			product: title,
			cartquan: cartquan,
			addtocart: addtocart

		})
	})

	const alertPlaceholder = document
		.getElementById('liveAlertPlaceholder')
	const alertTrigger = document.getElementById('liveAlertBtn')
	if (alertTrigger) {

		const wrapper = document.createElement('div')
		if (wrapper) {
			wrapper.innerHTML = [
				`<div class="alert alert-success alert-dismissible" role="alert">`,
				`   <div>Added to cart</div>`,
				'   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
				'</div>'].join('')

			alertPlaceholder.append(wrapper)
		}

	}
}

function handleDeleteStock(button) {
	let card = button.closest('.card');
	let title = card.querySelector('.card-title').innerText;
	let action = "deletestock";
	console.log(title);
	console.log(action);

	let response = fetch('addrem', {
		method: 'POST',
		header: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: new URLSearchParams({
			product: title,
			action: action
		})
	}).then(response => {
		if (response.ok) {
			location.reload();  // Refresh the page

		} else {
			console.error('Failed to remove item from stock');
		}
	}).catch(error => {
		console.error('Error:', error);
	});
}

function populateModal(button) {
	const product = button.getAttribute('data-product');
	const description = button.getAttribute('data-description');
	const quantity = button.getAttribute('data-quantity');
	const unitprice = button.getAttribute('data-unitprice');


	document.getElementById('product').value = product;
	document.getElementById('hiddenproduct').value = product;
	document.getElementById('description').value = description;
	document.getElementById('quantity').value = quantity;
	document.getElementById('unitprice').value = unitprice;

}