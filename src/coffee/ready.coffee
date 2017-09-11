isReady document, () ->
	console.log 'is ready'
	# pick out elements to use in the onsubmit listener
	emailForm = document.getElementById 'emailSuzy'
	hideOnSubmitSpan = document.getElementById 'hideOnSubmit'
	replaceOnSubmitSpan = document.getElementById 'replaceOnSubmit'

	# existence check and event listener attachment/detachment for the onsubmit function, remove and then add
	checkIfEl emailForm, 'submit', null, () ->
		submitForm event, emailForm, hideOnSubmitSpan, replaceOnSubmitSpan


	#pick out elements to be used in the mobile menu toggle click handler
	toggle = document.getElementById 'header__menu__toggle'
	menu = document.getElementById 'header__menu__hmm__id'
	overlay = document.getElementById 'menuOverlay'
	console.log toggle
	console.log menu
	toggleMenuAnon = () ->
		toggleMenu menu, overlay, toggle
	# existence check and event listener attachment/detachment for the mobile menu onclick function, remove and then add
	checkIfEl toggle, 'click', null, () ->
		console.log 'check if el add EL pre toggle add click'
		toggleAddClick toggle, menu, overlay
	#pick out elements to be used in the menu click handlers
	menuItems = [].slice.call(document.getElementsByClassName 'hmm__list')
	console.log menuItems
	checkIfEl overlay, 'click', toggleMenuAnon, toggleMenuAnon
	console.log 'before for each'
	menuItems.forEach (element, index, array) ->
		console.log element
		dataAttr = element.dataset.link
		console.log dataAttr
		makeEvent element, 'click', resetJump, () ->
			goToMenuItems menu, overlay, toggle, dataAttr
	console.log 'after for each'

	#if the contact input has value, retain the label float
	inputs = [].slice.call(document.getElementsByClassName 'contact__input')
	console.log inputs
	inputs.forEach (element, index, array) ->
		console.log element
		element.addEventListener 'blur', () ->
			if element.value
				element.classList.add 'contact__input--filled'
			else if element.classList.contains 'contact__input--filled'
				element.classList.remove 'contact__input--filled'

	#footer date
	footerDate = () ->
		thisDate = new Date().getFullYear()
		console.log thisDate
		return "2014-#{thisDate}&nbsp;"

	footerCopyright = document.getElementById 'footerCopy'
	theYear = document.createElement 'span'
	theYear.innerHTML = footerDate()
	footerCopyright.appendChild theYear
	# enlargeWindowAnon = () ->
	# 	enlargeWindow menu, overlay, toggle
	#
	# window.addEventListener('resize', enlargeWindowAnon, true)
