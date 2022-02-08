extends Camera


var left_pressed
var right_pressed
var forward_pressed
var backward_pressed
var play_pressed

var a_pressed
var b_pressed
var c_pressed
var d_pressed

var rotation_right_pressed
var rotation_left_pressed
var up_pressed
var down_pressed

var dictMazeFlag
var posCamera 
var posForward
var posBackward
var posDictL
var posDictR
var lDictMaze

var spatialNode

# Called when the node enters the scene tree for the first time.
func _ready():
	left_pressed=0
	right_pressed=0
	forward_pressed=0
	backward_pressed=0
	play_pressed=0
	a_pressed=0
	b_pressed=0
	c_pressed=0
	d_pressed=0
	
	rotation_right_pressed=0
	rotation_left_pressed=0
	up_pressed=0
	down_pressed=0
	
	dictMazeFlag = 0 
	posCamera = 0 
	posForward = 0
	posDictL = {0:3, 2:1, 1:0, 3:2}
	posDictR = {2:3, 0:1, 3:0, 1:2}
	posBackward = 2
	
	spatialNode=get_tree().get_root().get_node("Spatial")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dictMazeFlag == 0):
		lDictMaze = get_node(".").get_parent().getDictMaze()
		dictMazeFlag = 1 
		#print(lDictMaze)
	pass
#-------------- We uses those four function to have a general view -----------# 
func up():
	translation.y+=1
	
func down():
	translation.y-=1
	
func rotationRight():
	rotation_degrees.x +=90
	
func rotationLeft():
	rotation_degrees.x -=90
#-----------------------------------------------------------------------------#
func _input(ev):
	var tree=get_tree().get_root()
	var asp=tree.get_node("Spatial/AudioStreamPlayer")
	var file2Check = File.new()
	
	if (asp.playing==true):
		# If a sound is playing we quit this function without doing something
		return

	# Pressing a button and then releasing it is the set of two events 
	# Holding a button results in repeated input at fixed intervals of the character affiliated to the button	
	# That's why we use "not ev.echo" condition to avoid this case
	
	if ev is InputEventKey and ev.scancode == KEY_LEFT and not ev.echo and left_pressed==0:

		if(posForward == 0):
			print(lDictMaze[posCamera])
			if(file2Check.file_exists("res://textures_mur/"+str(posCamera)+"_"+str(3)+".png")):	
				spatialNode.turn_left()
				posForward = posDictL[posForward]
				posBackward = posDictL[posBackward]
		else: 
			if(file2Check.file_exists("res://textures_mur/"+str(posCamera)+"_"+str(posForward-1)+".png")):	
				spatialNode.turn_left()
				posForward = posDictL[posForward]
				posBackward = posDictL[posBackward]
		left_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_LEFT and not ev.echo and left_pressed==1:
		left_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_RIGHT and not ev.echo and right_pressed==0:
		if(posForward == 3):
			if(file2Check.file_exists("res://textures_mur/"+str(posCamera)+"_"+str(0)+".png")):	
				spatialNode.turn_right()
				posForward = posDictR[posForward]
				posBackward = posDictR[posBackward]
		else:
			if(file2Check.file_exists("res://textures_mur/"+str(posCamera)+"_"+str(posForward+1)+".png")):
				spatialNode.turn_right()
				posForward = posDictR[posForward]
				posBackward = posDictR[posBackward]
		right_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_RIGHT and not ev.echo and right_pressed==1:
		right_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_UP and not ev.echo and forward_pressed==0:
		if(lDictMaze[posCamera][6][posForward] != -1):	
			spatialNode.forward()
			forward_pressed=1
			posCamera = lDictMaze[posCamera][6][posForward]
		forward_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_UP and not ev.echo and forward_pressed==1:
		forward_pressed=0
		
	if ev is InputEventKey and ev.scancode == KEY_DOWN and not ev.echo and backward_pressed==0:
		if(lDictMaze[posCamera][6][posBackward] != -1):
			spatialNode.backward()
			posCamera = lDictMaze[posCamera][6][posBackward]
		backward_pressed=1
		
	elif ev is InputEventKey and ev.scancode == KEY_DOWN and not ev.echo and backward_pressed==1:
		backward_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_P and not ev.echo and play_pressed==0:
		spatialNode.play()
		play_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_P and not ev.echo and play_pressed==1:
		play_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_A and not ev.echo and a_pressed==0:
		spatialNode.answer_a()
		a_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_A and not ev.echo and a_pressed==1:
		a_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_B and not ev.echo and b_pressed==0:
		spatialNode.answer_b()
		b_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_B and not ev.echo and b_pressed==1:
		b_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_C and not ev.echo and c_pressed==0:
		spatialNode.answer_c()
		c_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_C and not ev.echo and c_pressed==1:
		c_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_D and not ev.echo and d_pressed==0:
		spatialNode.answer_d()
		d_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_D and not ev.echo and d_pressed==1:
		d_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_K and not ev.echo and rotation_right_pressed==0:
		rotationRight()
		rotation_right_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_K and not ev.echo and rotation_right_pressed==1:
		rotation_right_pressed = 0
		
	if ev is InputEventKey and ev.scancode == KEY_H and not ev.echo and rotation_left_pressed==0:
		rotationLeft()
		rotation_left_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_H and not ev.echo and rotation_left_pressed==1:
		rotation_left_pressed = 0
		
	if ev is InputEventKey and ev.scancode == KEY_U and not ev.echo and up_pressed==0:
		up()
		up_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_U and not ev.echo and up_pressed==1:
		up_pressed = 0
		
	if ev is InputEventKey and ev.scancode == KEY_N and not ev.echo and down_pressed==0:
		down()
		down_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_N and not ev.echo and down_pressed==1:
		down_pressed = 0
	



