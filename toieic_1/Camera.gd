extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dir # 0=N, 1=E, 2=S, 3=W
var left_pressed
var right_pressed
var forward_pressed
var backward_pressed
var rotation_left_pressed
var rotation_right_pressed
var up_pressed
var down_pressed
var dictMazeFlag
var posCamera 
var posForward
var posBackward
var posDictL
var posDictR
var lDictMaze
# commentaire


# Called when the node enters the scene tree for the first time.
# Initialization of variables
func _ready():
	dir=0
	left_pressed=0
	right_pressed=0
	forward_pressed=0
	backward_pressed=0
	rotation_right_pressed = 0 
	rotation_left_pressed = 0
	up_pressed = 0
	down_pressed = 0
	dictMazeFlag = 0 
	posCamera = 0 
	posForward = 0
	posDictL = {0:3, 2:1, 1:0, 3:2}
	posDictR = {2:3, 0:1, 3:0, 1:2}
	posBackward = 2
	print(translation)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dictMazeFlag == 0):
		lDictMaze = get_node(".").get_parent().getDictMaze()
		dictMazeFlag = 1 
		print(lDictMaze)
	pass
	
func get_dir():
	return dir

#------------------------------------------------------------------------------#

# Remarks

# First remark : 
# The rotation is based on trigonometric circle
# we can change our orientation by 90° using one of the right or left buttons
# 0 in the below trigonometric circle is the location of the camera each time 

	#     			PI/2
	#				 |	
	#				 |	
	#				 |	
	# PI ----------------------------- 0
	#				 |
	#				 |
	#				 |
	#			   -PI/2

# Second remark :
	# At the begening, we are pointing north by default so the variable dir is initiated at 0 
	# Turn right mean that dir will take dir + 1
	# Turn left mean that dir will take dir - 1
	#
	# 			   North = 0 
	#				  |	
	#				  |	
	# West = 3 --------------- East = 1
	# 				  |
	#				  |	
	#			   South = 2
	
	
func turn_left():
	# Based on the trigonometric circle turn the camera left mean add 90° = PI/2 to the y axe 
	rotation.y+=PI/2.0
	dir=dir-1
	if dir==-1:
		# Turning left while being at dir 0 brings us back to dir 3
		dir=3
	print(dir)

func turn_right():
	# Based on the trigonometric circle turn the camera right mean add -90° = -PI/2 to the y axe
	rotation.y-=PI/2.0
	dir=dir+1
	if dir==4:
		# Turning right while being at dir 4 brings us back to dir 0
		dir=0
	print(dir)
	
#------------------------------------------------------------------------------#

func backward():
	if (dir==0):
		translation.z+=2
	elif (dir==1):
		translation.x-=2
	elif (dir==2):
		translation.z-=2
	elif (dir==3):
		translation.x+=2

	print (translation)
	
func forward():
	if (dir==0):
		translation.z-=2
	elif (dir==1):
		translation.x+=2
	elif (dir==2):
		translation.z+=2
	elif (dir==3):
		translation.x-=2

	print (translation)
	
#------------- Get an overview on the labyrinth ----------------------#
func up():
	translation.y+=1
	
func down():
	translation.y-=1
	
func rotationRight():
	rotation_degrees.x +=90
	
func rotationLeft():
	rotation_degrees.x -=90
#-------------------------------------------------------#

# Called every time a button is pressed
func _input(ev):
	var tree=get_tree().get_root()
	var asp=tree.get_node("Spatial/AudioStreamPlayer")

	if (asp.playing==true):
		return
		
	# Pressing a button and then releasing it is the set of two events 
	# Holding a button results in repeated input at fixed intervals of the character affiliated to the button	
	# That's why we use "not ev.echo" condition to avoid this case
	 
	if ev is InputEventKey and ev.scancode == KEY_LEFT and not ev.echo and left_pressed==0:
		turn_left()
		# When the camera turns a change of frame is done
		# We treat it with these two lines
		posForward = posDictL[posForward]
		posBackward = posDictL[posBackward]
		left_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_LEFT and not ev.echo and left_pressed==1:
		left_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_RIGHT and not ev.echo and right_pressed==0:
		turn_right()
		# When the camera turns a change of frame is done
		# We treat it with these two lines
		posForward = posDictR[posForward]
		posBackward = posDictR[posBackward]
		right_pressed=1
	elif ev is InputEventKey and ev.scancode == KEY_RIGHT and not ev.echo and right_pressed==1:
		right_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_UP and not ev.echo and forward_pressed==0:
		# If there is no wall in this direction we can go forward 
		if(lDictMaze[posCamera][5][posForward] != -1):	
			forward()
			forward_pressed=1
			posCamera = lDictMaze[posCamera][5][posForward]
	elif ev is InputEventKey and ev.scancode == KEY_UP and not ev.echo and forward_pressed==1:
		forward_pressed=0

	if ev is InputEventKey and ev.scancode == KEY_DOWN and not ev.echo and backward_pressed==0:
		# If there is no wall in this direction we can go backward 
		if(lDictMaze[posCamera][5][posBackward] != -1):	
			backward()
			backward_pressed=1
			posCamera = lDictMaze[posCamera][5][posBackward]
	elif ev is InputEventKey and ev.scancode == KEY_DOWN and not ev.echo and backward_pressed==1:
		backward_pressed=0
		
	if ev is InputEventKey and ev.scancode == KEY_D and not ev.echo and rotation_right_pressed==0:
		rotationRight()
		rotation_right_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_D and not ev.echo and rotation_right_pressed==1:
		rotation_right_pressed = 0
		
	if ev is InputEventKey and ev.scancode == KEY_Q and not ev.echo and rotation_left_pressed==0:
		rotationLeft()
		rotation_left_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_Q and not ev.echo and rotation_left_pressed==1:
		rotation_left_pressed = 0
	
	if ev is InputEventKey and ev.scancode == KEY_Z and not ev.echo and up_pressed==0:
		up()
		up_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_Z and not ev.echo and up_pressed==1:
		up_pressed = 0
		
	if ev is InputEventKey and ev.scancode == KEY_S and not ev.echo and down_pressed==0:
		down()
		down_pressed = 1
	elif ev is InputEventKey and ev.scancode == KEY_S and not ev.echo and down_pressed==1:
		down_pressed = 0
	
	print("posCamera = ",posCamera)
