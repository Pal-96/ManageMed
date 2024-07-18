function handleDeleteRole(button) {
	let tbrow = button.closest('.tbrow');
	let roleId = tbrow.querySelector('#roleId').innerText;
	let action = "delete";
	console.log(roleId);
	console.log(action);
	let response = fetch('addrole', {
		method: 'POST',
		header: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: new URLSearchParams({
			roleId: roleId,
			action: action
		})
	}).then(response => {
		if (response.ok) {
			location.reload();  // Refresh the page

		} else {
			console.error('Failed to delete the role');
		}
	}).catch(error => {
		console.error('Error:', error);
	});
}
function populateModal(button) {
	const roleId = button.getAttribute('data-roleId');
	const roleName = button.getAttribute('data-roleName');

	document.getElementById('role').value = roleName;
	document.getElementById('editroleId').value = roleId;
	document.getElementById('action').value = "edit";

}