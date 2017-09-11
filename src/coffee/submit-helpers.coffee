



# function to call on submit form
submitForm = (event, el, hideMe, replaceMe) ->
	event.preventDefault()
	data = formToJson event.target.elements
	#call make request method promise
	request 'POST', 'php/send-mail.php', data
	.then (result) ->
		console.log result
		if result == 'success sending'
			message = 'Your message was successfully sent. '
		else if result == 'captcha fail'
			message = "Please check the captcha and try again. "
		else
			message = "Sorry, we couldn't send your message.  Try again later. "
		renderMessage el, hideMe, replaceMe, message
	.catch (error) ->
		message = "Sorry, we couldn't send your message.  Try again later. "
		renderMessage el, hideMe, replaceMe, message

# render a message
renderMessage = (el, hideMe, replaceMe, message) ->
	replaceMe.innerHTML = message
	hideMe.style.display = 'none'
	if message == 'Your message was successfully sent. '
		console.log 'success message'
		el.style.display = 'none'
	else
		console.log 'failed message'
		replaceMe.style.color = '#C70039'
	resetJump()
	window.location.hash = "\u0023contact"
