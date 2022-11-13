extends Popup


func _on_ini_pressed():
	var output: Array
	OS.execute("git", ["init", ProjectSettings.globalize_path("res://")], output, true, true)
	print(output[0])


func _on_push_pressed():
	var output: Array
	OS.execute("git", ["remote", "add", "origin", $VBoxContainer/HBoxContainer/repo.text], output, true, false)
	var output_string: String = output[0]
	print(output_string)
	
	output = []
	OS.execute("git", ["add", "*"], output, true, false)
	output_string = output[0]
	print(output_string)
	
	var message := Time.get_datetime_string_from_system().replace("T", " at time ")
	if $VBoxContainer/message.text != "": message = $VBoxContainer/message.text

	output = []
	OS.execute("git", ["commit", "-m", message], output, true, false)
	output_string = output[0]
	print(output_string)
	
	print("Pushing to GitHub...")
	OS.create_process("git", ["push", "origin", "master"], true)
