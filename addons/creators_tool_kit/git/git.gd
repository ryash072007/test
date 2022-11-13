@tool
extends Popup

func _ready():
	popup_window = false
	transient = true
	exclusive = true
	
	
	if FileAccess.file_exists("res://addons/creators_tool_kit/saves/git_repo.ryash"):
		var save_file = FileAccess.open("res://addons/creators_tool_kit/saves/git_repo.ryash", FileAccess.READ)
		$VBoxContainer/HBoxContainer/repo.text = save_file.get_as_text()

func _on_ini_pressed():
	var output: Array
	OS.execute("git", ["init", ProjectSettings.globalize_path("res://")], output, true, true)
	print(output[0])


func _on_push_pressed():
	var save_file = FileAccess.open("res://addons/creators_tool_kit/saves/git_repo.ryash", FileAccess.WRITE)
	save_file.store_string($VBoxContainer/HBoxContainer/repo.text)
	
	
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
