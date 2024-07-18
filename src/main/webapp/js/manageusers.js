function populateModal(button) {
	document.getElementById('username').disabled = "disabled";
	const firstname = button.getAttribute('data-fn');
	const lastname = button.getAttribute('data-ln');
	const username = button.getAttribute('data-un');
	const role = button.getAttribute('data-role');
	const password = button.getAttribute('data-pw');

	document.getElementById('firstname').value = firstname;
	document.getElementById('lastname').value = lastname;
	document.getElementById('username').value = username;
	document.getElementById('hid-username').value = username;
	document.getElementById('roleDropdown').textContent = role;
	document.getElementById('selectedRole').value = role;
	document.getElementById('password').value = password;
	document.getElementById('action').value = "edit";


}

function setRole(element) {
	let role = element.textContent;
	document.getElementById('roleDropdown').textContent = role;
	document.getElementById('selectedRole').value = role;
}

function addUser(button) {
	document.getElementById('username').disabled = "";
	document.getElementById('firstname').value = "";
	document.getElementById('lastname').value = "";
	document.getElementById('username').value = "";
	document.getElementById('hid-username').value = "";
	document.getElementById('roleDropdown').textContent = "Role";
	document.getElementById('password').value = "";
}

function handleDeleteUser(button) {
	let tbrowuser = button.closest('.tbrowuser');
	let username = tbrowuser.querySelector('#usertb').innerText;
	let action = "delete";
	console.log(action);

	let response = fetch('register', {
		method: 'POST',
		header: { 'Content-Type': 'application/x-www-form-urlencoded' },
		body: new URLSearchParams({
			username: username,
			action: action
		})
	}).then(response => {
		if (response.ok) {
			location.reload();  // Refresh the page

		} else {
			console.error('Failed to delete the user');
		}
	}).catch(error => {
		console.error('Error:', error);
	});
}
