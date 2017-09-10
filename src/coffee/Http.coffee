# xml http request class and make request promise method
Http = () ->
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
