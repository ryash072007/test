extends Popup


func _on_ini_pressed():
	var output: Array
	OS.execute("git", ["init", ProjectSettings.globalize_path("res://")], output, true, true)
	print(output[0])


func _on_push_pressed():
	var output: Array
	OS.execute("git", ["remote", "add", "origin", $VBoxContainer/HBoxContainer/repo.text], output, true, true)
	var output_string: String = output[0]
	
	
	output = []
	OS.execute("git", ["add", "*"], output, true, true)
	output_string = output[0]
	
	
	var message := Time.get_datetime_string_from_system()
	if $VBoxContainer/message.text != "": message = $VBoxContainer/message.text

	output = []
	OS.execute("git", ["commit", "-m", message], output, true, true)
	output_string = output[0]
	
	output = []
	OS.execute("git", ["push", "origin", "master"], output, true, true)
	output_string = output[0]
