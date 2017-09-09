# xml http request class and make request promise method
Http() ->
	makeRequest(method, path, data) ->
		new Promise(resolve, reject) ->
			req = new XMLHttpRequest()
			req.open method, path
			req.onload = () ->
				if req.status == 200
					resolve 'success'
				else
					reject Error req.statusText
			req.onerror = () ->
				reject Error 'unknown error'
			req.send data

# pick out elements to use in the submit message process
emailForm = document.getElementById emailSuzy
hideOnSubmitSpan = document.getElementById hideOnSubmit
showOnSubmitSpan = document.getElementById showOnSubmit
replaceOnSubmitSpan = document.getElementById replaceOnSubmit


# function to call onsubmit
submitForm = (event) ->
	event.preventDefault()
	#new Http instance
	http = new Http()
	#call make request method promise
	http.makeRequest 'POST', 'send-mail.php', emailSuzy.serialize()
	.then(result) ->
		successAction()
	.catch(error) ->
		failAction()

# what to do if the send submission succeeds
successAction = () ->
	message = 'Your message was successfully sent!'
	emailForm.style.display = 'none'
	hideOnSubmitSpan.style.display = 'none'
	showOnSubmitSpan.style.display = 'unset'
	replaceOnSubmitSpan.innerHtml = message

# what to do if the send submission fails
failAction = () ->
	message = "Sorry, we couldn't send your message.  Please call or try again later."
	replaceOnSubmitSpan.innerHtml = message
	replaceOnSubmitSpan.style.color = '#C70039'

# event listener for the onsubmit function
emailForm.addEventListener 'submit', (event) -> submitForm event



#onclick show the mobile menu

#onclick hide the mobile menu, remove any # and jump to the #
