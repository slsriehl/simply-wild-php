#mobile menu click event callback
toggleAddClick = (clickEl, menu, overlay) ->
	console.log 'toggle add click'
	toggleMenu menu, overlay, clickEl

#check if element has class
toggleMenu = (menu, overlay, toggle) ->
	console.log 'toggle menu'
	if window.getComputedStyle(menu, null).getPropertyValue('visibility') == 'hidden'
		console.log 'toggle menu'
		menu.style.visibility = 'unset'
		overlay.style.visibility = 'unset'
		toggle.style.visibility = 'hidden'
		menu.style.zIndex = '150'
		overlay.style.zIndex = '105'
	else
		console.log 'toggle no menu'
		menu.style.visibility = 'hidden'
		overlay.style.visibility = 'hidden'
		toggle.style.visibility = 'unset'
		menu.style.zIndex = '-1'
		overlay.style.zIndex = '-1'

#menu item reset jump helper/remove event
resetJump = () ->
	console.log 'reset jump'
	history.pushState "", document.title, window.location.pathname + window.location.search
#menu item onclick event callback
goToMenuItems = (parentEl, overlay, toggle, jumpName) ->
	console.log 'go to menu items'
	resetJump()
	toggleMenu parentEl, overlay, toggle
	window.location.hash = "\u0023#{jumpName}"

# enlargeWindow = (menu, overlay, toggle) ->
# 	if document.documentElement.clientWidth >= '812px'
# 		console.log 'foo'
# 		menu.style = ''
# 		overlay.style = ''
# 		toggle.style.display = window.getComputedStyle(toggle, null).getPropertyValue('display')
