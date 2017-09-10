# validate the fields sent to form to JSON so they're excluded if blank
isValidElement = (element) ->
	return element.name and element.value

# check if a checkbox is checked and include in formToJSON
isValidValue = (element) ->
	return (!['checkbox', 'radio'].includes(element.type) or element.checked)

# convert the input in the form inputs into a json object
formToJson = (elements) ->
	[].reduce.call(elements, (data, element) ->
		if isValidElement(element) and isValidValue(element)
			data[element.name] = element.value
		return data
	, {})
