function sendEmail() {
	let params = {
		fromEmail: document.getElementById("email").value,
		name: document.getElementById("name").value,
		feedback: document.getElementById("feedback").value	
}

emailjs.send("service_2fuvsah", "template_0jlswnq", params).then(alert("Email has been sent!"))
}