extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var initClick = false
var init_x = 0
var init_y = 0
var newVal = 0
var newVal2 = 0.5
var curX
var curY
var Anim
var Anim2
var AnimLength = 2
var Cam
var gate
var pic




# Called when the node enters the scene tree for the first time.
func _ready():
	Anim = get_node("/root/Spatial/AnimationPlayer")
	Anim.play("scene_rot")
	Anim.stop()
	
	Anim2 = get_node("/root/Spatial/AnimationPlayer2")
	Anim2.play("scene_vert")
	Anim2.seek(newVal2, true)
	Anim2.stop()
	
	Cam = get_node("/root/Spatial/cam_track/cam_vertical/Camera")
	gate = get_node("/root/Spatial/Gate_02")
	
	pic = 1
	

func _input(event):
	if event.is_action_pressed("click"): 
		initClick = true
		init_x = get_viewport().get_mouse_position()[0]
		init_y = get_viewport().get_mouse_position()[1]
		print(init_x, init_y)
		
	if event.is_action_pressed("zoom_in"):
		Cam.fov = Cam.fov - 1
	if event.is_action_pressed("zoom_out"):
		Cam.fov = Cam.fov + 1
		
	if event.is_action("ui_left"):
		gate.translation[2] = gate.translation[2] + 0.05
	if event.is_action("ui_right"):
		gate.translation[2] = gate.translation[2] - 0.05
	if event.is_action("ui_up"):
		gate.translation[1] = gate.translation[1] + 0.05
	if event.is_action("ui_down"):
		gate.translation[1] = gate.translation[1] - 0.05
		
	if event.is_action_pressed("screenshot"):
		var image = get_viewport().get_texture().get_data()
		var path = OS.get_user_data_dir() + "/" + str(pic) + ".png"
		image.flip_y()
		image.save_png(path)
		pic = pic + 1
		$cam_track/cam_vertical/Camera/Node/CanvasLayer/Shot_Panel/Label.text = path
		#$cam_track/cam_vertical/Camera/Node/CanvasLayer/Shot_Panel/Popup.popup()
		
		
	if event.is_action_pressed("hide"):
		if(get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Card_Panel").visible):
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Card_Panel").visible = false
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Water_Panel2").visible = false
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Color_Panel").visible = false
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Shot_Panel").visible = false
		else:
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Card_Panel").visible = true
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Water_Panel2").visible = true
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Color_Panel").visible = true
			get_node("/root/Spatial/cam_track/cam_vertical/Camera/Node/CanvasLayer/Shot_Panel").visible = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(initClick == true):
		#init_y = get_viewport().get_visible_rect().size[0]
		
		curX = (init_x - get_viewport().get_mouse_position()[0])/get_viewport().get_visible_rect().size[0]
		curY = (init_y - get_viewport().get_mouse_position()[1])/get_viewport().get_visible_rect().size[1]
		#newVal = newVal + (curX * AnimLength)
		var val1 = newVal + (curX * AnimLength)
		if (val1 < 0):
			val1 = val1 + 2
		if (val1 > 2):
			val1 = val1 - 2
		#print(newVal)
		Anim.seek(val1, true)
		Anim.stop()
		
		var val2 = newVal2 + curY
		if (val2 < 0):
			val2 = 0
		if (val2 > 1):
			val2 = 1
		Anim2.seek(val2, true)
		Anim2.stop()
		
		if Input.is_action_just_released("click"):
			initClick = false
			newVal = val1
			newVal2 = val2
			if (newVal < 0):
				newVal = 2 - newVal
			if (newVal > 2):
				newVal = newVal - 2
			
		
