function loadContent(page) {
	document.getElementById('contentFrame').src = page;
	document.getElementById('searchForm').action = page;
}