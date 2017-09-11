# xml http request class and make request promise method
request = (method, path, data) ->
	new Promise (resolve, reject) ->
		req = new XMLHttpRequest()
		# req.setRequestHeader "Content-Type", "application/json;charset=UTF-8"
		req.open method, path
		req.onload = () ->
			if req.status == 200
				resolve req.responseText
			else
				reject Error req.statusText
		req.onerror = () ->
			reject Error 'unknown error'
		req.send JSON.stringify data
