@tool
extends Popup


var butler_path: String = "butler"

func _ready():
	$title.text += " - " + OS.get_name()
#	match OS.get_name():
#		"Windows":
#			butler_path = "res://addons/creators_tool_kit/itch/builds/win64/butler.exe"
#		"Linux":
#			butler_path = "res://addons/creators_tool_kit/itch/builds/linux64/butler"
#		"macOS":
#			butler_path = "res://addons/creators_tool_kit/itch/builds/macOS/butler"
	
	
	$VBoxContainer/exportLbl.text = ""
	popup_window = false
	transient = true
	exclusive = true
	$VBoxContainer/export/chooseFile.title = "Choose folder with executables"


func _on_itch_sign_in_pressed():
	$VBoxContainer/exportLbl.text = "Signing in..."
	$VBoxContainer/exportLbl.visible = true
	var thread: Thread = Thread.new()
	thread.start(func():
	
		var output: Array
		var path: String = ProjectSettings.globalize_path(butler_path)
		OS.execute(path, ["login"], output, true, false)
		var output_string: String = output[0]
		if "local credentials are valid" in output_string:
			OS.alert("You are already logged into Itch.io!", "Already logged into Itch.io!")
			)


func _on_export_pressed():
	if $VBoxContainer/HBoxContainer/username.text == "" or $VBoxContainer/HBoxContainer/gamename.text == "":
		OS.alert("Please fill in your username and Game Name.", "Enter details")
		return
	$VBoxContainer/export/chooseFile.visible = true


func _on_choose_file_dir_selected(dir):
	var thread: Thread = Thread.new()
	thread.start(Callable(self, "run_push").bind(dir))
	$VBoxContainer/exportLbl.text = "Pushing..."
	$VBoxContainer/exportLbl.visible = true

func run_push(dir):
	var output: Array
	var path: String = ProjectSettings.globalize_path(butler_path)
	OS.execute(path, ["push", ProjectSettings.globalize_path(dir), $VBoxContainer/HBoxContainer/username.text + "/" + $VBoxContainer/HBoxContainer/gamename.text + ":windows-64"], output, true, false)
	var output_string: String = output[0]
#	print(output_string)
	if "invalid game" in output_string:
		OS.alert("Invalid username or game name. Please ensure that the game exists in your itch.io page.", "Invalid Game Push to Itch")
	elif "should be up in a bit" in output_string:
		OS.alert("Successfully published build.", "Successful Push to Itch.io")
	$VBoxContainer/exportLbl.visible = false


func _on_itch_logout_pressed():
	var path: String = ProjectSettings.globalize_path(butler_path)
	$VBoxContainer/exportLbl.visible = true
	$VBoxContainer/exportLbl.text = "Logging out..."
	OS.create_process(path, ["logout"], true)



