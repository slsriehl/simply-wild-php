



# function to call on submit form
submitForm = (event, el, hideMe, replaceMe) ->
	event.preventDefault()
	data = formToJson event.target.elements
	#new Http instance
	http = new Http()
	#call make request method promise
	http.makeRequest 'POST', 'send-mail.php', data
	.then(result) ->
		renderMessage el, hideMe, replaceMe, result
	.catch(error) ->
		message = "Sorry, we couldn't send your message.  Please call or try again later."
		renderMessage el, hideMe, replaceMe, message

# render a message
renderMessage = (el, hideMe, replaceMe, message) ->
	if message == 'Your message was successfully sent!'
		el.style.display = 'none'
		hideMe.style.display = 'none'
	else
		replaceMe.style.color = '#C70039'
	replaceMe.innerHtml = message
	resetJump()
	window.location.hash = "\u0023contact"
