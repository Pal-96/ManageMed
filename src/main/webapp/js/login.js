const alertPlaceholder = document
				.getElementById('liveAlertPlaceholder')
			const wrapper = document.createElement('div')
			if (wrapper) {
				wrapper.innerHTML = [
						`<div class="alert alert-warning alert-dismissible" role="alert">`,
						`   <div>Invalid credentials</div>`,
						'   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
						'</div>' ].join('')

				alertPlaceholder.append(wrapper)
			}