extends CanvasLayer


var cardSlider
var card1Boot
var card1G
var card2Boot
var card2G
var Env

var gate_top
var gate_side
var root_spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	root_spatial = get_node("/root/Spatial")
	Env = get_node("/root/Spatial/cam_track/cam_vertical/Camera/WorldEnvironment")
	
	cardSlider = get_node("/root/Spatial/Gate_02/AnimationPlayer")
	cardSlider.play("card")
	cardSlider.seek(0.5, true)
	cardSlider.stop()
	
	card1Boot = get_node("/root/Spatial/Gate_02/card/Bootlegger")
	card1G = get_node("/root/Spatial/Gate_02/card/Gman")
	card2Boot = get_node("/root/Spatial/Gate_02/card2/Bootlegger")
	card2G = get_node("/root/Spatial/Gate_02/card2/Gman")
	
	gate_top = get_node("/root/Spatial/Gate_02/Top2")
	gate_side = get_node("/root/Spatial/Gate_02/Side Orange2")
	
	$Water_Panel2/Water_ColorPickerButton.color = Env.environment.fog_color
	$Color_Panel/Gate1_ColorPickerButton.color = gate_top.get_surface_material(0).albedo_color
	$Color_Panel/Gate2_ColorPickerButton.color = gate_side.get_surface_material(0).albedo_color
	
	$Shot_Panel/Label.text = OS.get_user_data_dir()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	#$HTTPRequest2.request("http://kottakkakathu.com/reshma/light/index.php?do=1&"+str(OS.get_unix_time()))
	#get_node("/root/Spatial/cam_track/cam_vertical/Camera/WorldEnvironment").environment.fog_enabled = true
	if (card1Boot.visible):
		card1Boot.visible = false
		card1G.visible = true
		card2Boot.visible = true
		card2G.visible = false
	else:
		card1Boot.visible = true
		card1G.visible = false
		card2Boot.visible = false
		card2G.visible = true




func _on_Card_HSlider_value_changed(value):
	$Card_Panel/Card_Label.text = "Card Offset: " + str(value)
	cardSlider.play("card")
	cardSlider.seek(value * 0.01, true)
	cardSlider.stop()


# warning-ignore:unused_argument
func _on_Water_CheckBox_toggled(button_pressed):
	if($Water_Panel2/Water_CheckBox.pressed):
		Env.environment.fog_enabled = true
	else:
		Env.environment.fog_enabled = false


func _on_Water_ColorPickerButton_color_changed(color):
	Env.environment.fog_color = color


func _on_Water_HSlider_value_changed(value):
	$Water_Panel2/Water_CheckBox/Label.text = "Turbidity: " + str(value)
	Env.environment.fog_depth_end = 30 - (29 * value/100)




func _on_Gate1_ColorPickerButton_color_changed(color):
	gate_top.get_surface_material(0).albedo_color = color


func _on_Gate2_ColorPickerButton_color_changed(color):
	gate_side.get_surface_material(0).albedo_color = color



func _on_Card_CheckBox_toggled(button_pressed):
	if($Card_Panel/Card_CheckBox.pressed):
		get_node("/root/Spatial/Gate_02/card").visible = true
		get_node("/root/Spatial/Gate_02/card2").visible = true
	else:
		get_node("/root/Spatial/Gate_02/card").visible = false
		get_node("/root/Spatial/Gate_02/card2").visible = false
