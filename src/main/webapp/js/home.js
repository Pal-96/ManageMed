function loadContent(page) {
	document.getElementById('contentFrame').src = page;
	document.getElementById('searchForm').action = page;
}
console.log("Inside home.js");
const alertPlaceholder = document
	.getElementById('liveAlertPlaceholder')
const wrapper = document.createElement('div')
if (wrapper) {
	wrapper.innerHTML = [
		`<div class="alert alert-warning alert-dismissible" role="alert">`,
		`   <div>Product already exists</div>`,
		'   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
		'</div>'].join('')

	alertPlaceholder.append(wrapper)
}