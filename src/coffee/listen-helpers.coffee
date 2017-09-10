# event listener helpers that work for IE8+

#IE8 compliant document.ready
isReady = (el, handler) ->
	if el.addEventListener
		console.log 'is ready add EL'
		el.addEventListener 'DOMContentLoaded', handler
	else
		console.log 'is ready not EL'
		el.readyState == 'complete'
		undefined

#attach/add event
addEvent = (el, type, handler) ->
	console.log 'add event'
	if el.attachEvent
		console.log 'attach event'
		el.attachEvent "on#{type}", handler
	else
		console.log 'add event listener'
		el.addEventListener type, handler

#remove event handler
removeEvent = (el, type, handler) ->
	console.log 'remove event'
	if el.detachEvent
		console.log 'detach event'
		el.detachEvent "on#{type}", handler
	else
		console.log 'remove event listener'
		el.removeEventListener type, handler

#remove and then attach handler
makeEvent = (el, type, removeHandler, addHandler) ->
	console.log 'make event'
	removeEvent el, type, removeHandler
	addEvent el, type, addHandler

checkIfEl = (el, type, removeHandler, addHandler) ->
	console.log 'check if el'
	if el
		console.log 'el exists'
		makeEvent el, type, removeHandler, addHandler
	else
		console.log 'no el'
		return
