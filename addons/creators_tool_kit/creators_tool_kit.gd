@tool
extends EditorPlugin

var itch := preload("res://addons/creators_tool_kit/itch/itch.tscn")

func _enter_tree():
	add_tool_menu_item("Itch Options", Callable(self, "open_itch_tool"))


func open_itch_tool():
	var itch_tool: Popup = itch.instantiate()
	var editor_size: Vector2 = get_editor_interface().get_base_control().size
	itch_tool.position.x = (editor_size.x - itch_tool.size.x) / 2
	itch_tool.position.y = (editor_size.y - itch_tool.size.y) / 2
	get_editor_interface().get_base_control().add_child(itch_tool)
	itch_tool.popup()

func _exit_tree():
	remove_tool_menu_item("Itch Options")
