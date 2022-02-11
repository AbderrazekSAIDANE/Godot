extends Spatial


var client  # Used to send UDP messages to vosk application

var server # Used to receive UDP posts from vosk application  

var muted # Inform if we need to mute the microphone or no 

var lTextures_mur

var lSons # sounds list 

var dictMaze # Important : this variable contains all the information needed to identify and create the cells

var pos # indicates the position of the player

var dir # Indicates the direction or orientation of the player

var file2Check # Used to check if we have picture that refer to a wall

var sound2Check # Used to check if we have sound that refer to question for a picture

var lancementStatement # Variable used to play statement for just one time 


var localisationQuestion
var turnRight
var turnLeft
var played
# Called when the node enters the scene tree for the first time.
func _ready():
	# Initilisation of varibles
	lancementStatement = 0
	turnRight = 0 
	turnLeft = 0
	played = 0
	localisationQuestion = [[3,0,0],[6,0,0],[12,3,0],[15,0,0],[18,1,0]]
	
	file2Check = File.new() 
	dictMaze={}
	pos=0
	dir=0
	$Control/Label.text="NORD"
	muted=0
	
	#
	# creerCellule(...) rend comme valeur de retour une liste composée de 12 élements
	# 0 / le noeud
	# 1 / le noeud fils au nord
	# 2 / le noeud fils à l'est
	# 3 / le noeud file au sud
	# 4 / le noeud fils à l'ouest
	# 5 / la liste des murs [nord, est,sud, ouest] 0=pas de mur, 1=mur
	# 6 / la liste des destinations [nord, est,sud, ouest] -1=pas de destination, >=0 une destination
	# 7 / la cellule de base de notre cellule, où se trouve la porte
	# 8 / la liste des numéros de cellules associées à une cellule avec porte, [] si pas de porte
	# 9 / le mur à ouvrir contenant la porte 0=X, 1=E, 2=S, 3=O
	# 10 / la réponse donnée par le joueur dans cette cellule, -1=pas encore répondu, 0=A, 1=B, 2=C, 3=D
	# 11 / la réponse attendue 0=A, 1=B, 2=C, 3=D
	# On stocke cette liste comme valeur dans le dictionnaire dictMaze, la clé est le numéro de la cellule
	#
	#                  0 1 2         3         4            5  6       7 8  9
	#------------------ Premier Bloc --------------------#
	var l=creerCellule(0,0,[0,1,1,1],[0,1,2,3],[1,-1,-1,-1],-1,[1,2,3],0,-1,-1, 0)
	add_child(l[0])
	dictMaze[0]=l
	l=creerCellule(0,-2,[1,0,0,1],[0,1,2,3],[-1,2,0,-1],-1,[],-1,-1,-1, 1)
	add_child(l[0])
	dictMaze[1]=l
	l=creerCellule(2,-2,[0,1,1,0],[0,1,2,3],[3,-1,-1,1],-1,[],-1,-1,-1, 2)
	add_child(l[0])
	dictMaze[2]=l
	l=creerCellule(2,-4,[1,1,1,1],[0,1,2,3],[-1,-1,2,4],3,[3],3,-1,2, 3)
	add_child(l[0])
	dictMaze[3]=l
	#------------------ Deuxième Bloc --------------------#
	l=creerCellule(0,-4,[0,0,1,1],[0,1,2,3],[5,3,-1,-1],-1,[],-1,-1,-1, 4)
	add_child(l[0])
	dictMaze[4]=l
	l=creerCellule(0,-6,[0,1,0,1],[0,1,2,3],[6,-1,4,-1],-1,[],-1,-1,-1, 5)
	add_child(l[0])
	dictMaze[5]=l
	l=creerCellule(0,-8,[0,1,0,1],[0,1,2,3],[7,-1,5,-1],7,[],-1,-1,1, 6)
	add_child(l[0])
	dictMaze[6]=l
	l=creerCellule(0,-10,[1,1,0,1],[0,1,2,3],[8,-1,6,-1],-1,[6],0,-1,-1, 7)
	add_child(l[0])
	dictMaze[7]=l
	#------------------ Troisième Bloc --------------------#
	l=creerCellule(0,-12,[0,1,0,1],[0,1,2,3],[9,-1,7,-1],-1,[],-1,-1,-1, 8)
	add_child(l[0])
	dictMaze[8]=l
	l=creerCellule(0,-14,[1,1,0,0],[0,1,2,3],[-1,-1,8,10],-1,[],-1,-1,-1, 9)
	add_child(l[0])
	dictMaze[9]=l
	l=creerCellule(-2,-14,[0,0,1,1],[0,1,2,3],[11,9,-1,-1],-1,[],-1,-1,-1, 10)
	add_child(l[0])
	dictMaze[10]=l
	l=creerCellule(-2,-16,[1,1,0,0],[0,1,2,3],[-1,-1,10,12],-1,[],-1,-1,-1, 11)
	add_child(l[0])
	dictMaze[11]=l
	l=creerCellule(-4,-16,[1,0,1,1],[0,1,2,3],[13,11,-1,-1],12,[12],0,-1,3, 12)
	add_child(l[0])
	dictMaze[12]=l
	#------------------ Quatrième Bloc --------------------#
	l=creerCellule(-4,-18,[0,1,0,1],[0,1,2,3],[14,-1,12,-1],-1,[],-1,-1,-1, 13)
	add_child(l[0])
	dictMaze[13]=l
	l=creerCellule(-4,-20,[0,1,0,1],[0,1,2,3],[15,-1,13,-1],-1,[],-1,-1,-1, 14)
	add_child(l[0])
	dictMaze[14]=l
	l=creerCellule(-4,-22,[1,1,0,1],[0,1,2,3],[-1,16,14,-1],15,[15],1,-1,0, 15)
	add_child(l[0])
	dictMaze[15]=l
	#------------------ Cinquième Bloc --------------------#
	l=creerCellule(-2,-22,[1,0,1,0],[0,1,2,3],[-1,17,-1,15],-1,[],-1,-1,-1, 16)
	add_child(l[0])
	dictMaze[16]=l
	l=creerCellule(0,-22,[1,0,1,0],[0,1,2,3],[-1,18,-1,16],-1,[],-1,-1,-1, 17)
	add_child(l[0])
	dictMaze[17]=l
	l=creerCellule(2,-22,[1,1,1,0],[0,1,2,3],[-1,-1,19,17],18,[18],2,-1,2, 18)
	add_child(l[0])
	dictMaze[18]=l
	#------------------ Cinquième Bloc --------------------#
	l=creerCellule(2,-20,[1,1,1,0],[0,1,2,3],[0,18,-1,20],-1,[],-1,-1,1, 19)
	add_child(l[0])
	dictMaze[19]=l
	
	# Creation of the server on port 4242
	server = UDPServer.new()
	# The server will always listen on the port 4242 waiting for someting from his clients
	server.listen(4242)
	# Creation of the clien to send messages on port 4243
	client= PacketPeerUDP.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This function is called at every picture 

	# At pictures in position 3 with direction 0 we play statement.wav
	# For one time
	played = 0  
	
	if((pos == 0 and dir == 0) and lancementStatement==0):
		#$AudioStreamPlayer.stream=load("res://sons/statement.wav")
		#$AudioStreamPlayer.play()
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Mute".to_utf8())
		muted=1
		lancementStatement = 1
	
	if(pos == 1 and dir == 0 and turnRight == 0):
		$AudioStreamPlayer.stream=load("res://sons/right.wav")
		$AudioStreamPlayer.play()
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Mute".to_utf8())
		muted=1
		turnRight = 1
		
	if(pos == 2 and dir == 1 and turnLeft == 0):
		$AudioStreamPlayer.stream=load("res://sons/left.wav")
		$AudioStreamPlayer.play()
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Mute".to_utf8())
		muted=1
		turnLeft = 1

		
	print(pos, dir)
	for i in range (len(localisationQuestion)):
		if(pos == localisationQuestion[i][0] and dir ==localisationQuestion[i][1] and localisationQuestion[i][2] == 0):
			$AudioStreamPlayer.stream=load("res://sons/HereAquestion.wav")
			$AudioStreamPlayer.play()
			client.connect_to_host("127.0.0.1", 4243)
			client.put_packet("Mute".to_utf8())
			muted=1
			localisationQuestion[i][2] = 1
			pass 
	# if this condition is verified : a sound is played and the microphone is muted
	# we send a UDP request to unmeted the vosk application  	
	if ($AudioStreamPlayer.playing==false and muted==1):
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Unmute".to_utf8())
		muted=0
		return
	
	server.poll() # Important! used to process new packets
	if server.is_connection_available(): # If a packet with a new address/port combination was received on the socket.
		var peer : PacketPeerUDP = server.take_connection() # Returns the first pending connection 
		var pkt = peer.get_packet() # Gets a raw packet
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		var pktstr=pkt.get_string_from_utf8()
		print(len(pktstr)," ",pktstr)
		if (len(pktstr)>0):
			if (pktstr[0]=='f'):
				forward()
			if (pktstr[0]=='r'):
				turn_right()
			elif (pktstr[0]=='l'):
				turn_left()
			elif (pktstr[0]=='p'):
				# In this case we have to play the equivalent sound and mute the microphone
				play()
			elif (pktstr[0]=='a' and dictMaze[pos][11] !=-1 and played == 1):
				answer_a()
			elif (pktstr[0]=='b' and dictMaze[pos][11]!=-1 and played == 1):
				answer_b()
			elif (pktstr[0]=='c' and dictMaze[pos][11]!=-1 and played == 1):
				answer_c()
			elif (pktstr[0]=='d' and dictMaze[pos][11]!=-1 and played == 1):
				answer_d()
#----------------------------------- Remarks -------------------------------------------#

# First remark : 
# The rotation is based on trigonometric circle
# we can change our orientation by 90° using one of the right or left buttons
# 0 in the below trigonometric circle is the location of the camera each time 

	#     			  0
	#				  |	
	#				  |	
	#				  |	
	# -PI/2 ------------------------- PI/2
	#				  |
	#				  |
	#				  |
	#			      PI

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
	if(dir == 0):
		if(file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(3)+".png")):
			$Camera.rotation.y+=PI/2.0
			dir=3
			setLabel()
	else: 
		if(file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(dir-1)+".png")):
			$Camera.rotation.y+=PI/2.0
			dir=dir-1
			setLabel()
			
func setLabel():
	match dir:
		0:
			$Control/Label.text="NORD"
		1:
			$Control/Label.text="EST"
		2:
			$Control/Label.text="SUD"
		3:
			$Control/Label.text="OUEST"

func turn_right():
	# Based on the trigonometric circle turn the camera right mean add -90° = -PI/2 to the y axe
	if(dir == 3):
		if(file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(0)+".png")):
			$Camera.rotation.y-=PI/2.0
			dir=0
			setLabel()
	else:
		if(file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(dir+1)+".png")):
			$Camera.rotation.y-=PI/2.0
			dir=dir+1
			setLabel()

# To move we need to check if there is no wall in our way 
# We can get this information in positions 5 and 6 of dictMaze
func forward():
	print(dictMaze[0])
	var lWalls=dictMaze[pos][5]
	var lDirections=dictMaze[pos][6]

	# si il n'y a pas de mur dans la direction où on veut aller, alors le déplacement est valide
	# If there is no wall in our direction we can move
	#  Because we made some modifications we need to check if in this direction there is a way 

	if (lDirections[dir]!=-1 and lWalls[dir]== 0):

		if (dir==0):
			$Camera.translation.z-=2

		elif (dir==1):
			$Camera.translation.x+=2

		elif (dir==2):
			$Camera.translation.z+=2

		elif (dir==3):
			$Camera.translation.x-=2

		pos=lDirections[dir]

func backward():
	print(dictMaze[0])
	var lWalls=dictMaze[pos][5]
	var lDirections=dictMaze[pos][6]

	# si il n'y a pas de mur dans la direction où on veut aller, alors le déplacement est valide
	# If there is no wall in our direction we can move
	#  Because we made some modifications we need to check if in this direction there is a way 

	if (lDirections[dir-2]!=-1 and lWalls[dir-2]== 0):

		if (dir==0):
			$Camera.translation.z+=2

		elif (dir==1):
			$Camera.translation.x-=2

		elif (dir==2):
			$Camera.translation.z-=2

		elif (dir==3):
			$Camera.translation.x+=2

		pos=lDirections[dir-2]

# When we play a sound we have to mute our microphone
func play():
	sound2Check = File.new()
	if (sound2Check.file_exists("res://sons/"+str(pos)+"_"+str(dir)+".wav")):
		$AudioStreamPlayer.stream=load("res://sons/"+str(pos)+"_"+str(dir)+".wav")
		$AudioStreamPlayer.play()
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Mute".to_utf8())
		muted=1
		played = 1 

func answer_a():
	checkAnswer(0)
	print("Answer A")
	
func answer_b():
	checkAnswer(1)
	print("Answer B")
	
func answer_c():
	checkAnswer(2)
	print("Answer C")
	
func answer_d():
	checkAnswer(3)
	print("Answer D")

# We this function we will answer to the questions
# If our answers are good and right our wall of a cell with be hide and we can go further
func checkAnswer(r):
	var celluleBase=dictMaze[pos][7] # Element 7 of dictMaze is for the cell who contain a door
	
	# if celluleBase = -1 it mean this cell don't contain a door
	var lCellules=dictMaze[celluleBase][8] # Element 8 of dictMaze contain aaa list of cells who contain a question
	# that the player need to answer to go further in the game 
	# Element 10 is the answer of the player, if the element is -1 then the player did not answer
	print(celluleBase, lCellules)
	
	dictMaze[pos][10]=r
	
	var okPourOuvrir=true
	# and we go through the list of cells associated with the base cell
	for c in lCellules:
		var cell=dictMaze[c]
		# if the value entered by the player for this cell (position 10)
		# is not equal to the expected value (position11) then the door cannot open
		if cell[10]!=cell[11]:
			okPourOuvrir=false
	# If all cells to open the door have correct answers
	if (okPourOuvrir==true):
		# we get the list for the base cell
		var b=dictMaze[celluleBase]
		# we retrieve the index of the wall where the door is (0=N, 1=E, 2=S, 3=O)
		var porteAouvrir=b[9]
		# If it is a door to the north, we hide the north wall, and we modify the list of walls
		# to create an opening by putting 0 in the right place in the list
		if (porteAouvrir==0):
			b[1].hide()
			b[5][0]=0
			forward()
			if(dir == 3):
				turn_right()
			if(dir ==0):
				forward()
			forward()
		elif (porteAouvrir==1):
			b[2].hide()
			b[5][1]=0
			turn_right()
			forward()
		elif (porteAouvrir==2):
			b[3].hide()
			b[5][2]=0
			turn_right()
			forward()
		elif (porteAouvrir==3):
			b[4].hide()
			b[5][3]=0
			turn_left()
			forward()
			
func chargerTextures():
	pass
	var it=ImageTexture.new()
	it.load("res://textures_mur/brique1.jpg")
	lTextures_mur.append(it)
	print("Textures chargées")

func chargerSons():
	pass
	var s=load("res://sons/statement.wav")
	lSons.append(s)
	print("Sons chargés")
	
func creerCellule(x,z,lWalls,lTextureNumbers,lDestinations,celluleBase,lCellules,porteAOuvrir,reponse,reponseAttendue, pos):

	var n=Spatial.new()
	n.translate(Vector3(x,0.0,z))
	
	var nNord=Spatial.new()
	nNord.translate(Vector3(0.0,0.0,-1))
	n.add_child(nNord)

	var nEst=Spatial.new()
	nEst.translate(Vector3(1.0,0.0,0.0))
	n.add_child(nEst)

	var nSud=Spatial.new()
	nSud.translate(Vector3(0.0,0.0,1.0))
	n.add_child(nSud)

	var nOuest=Spatial.new()
	nOuest.translate(Vector3(-1.0,0.0,0.0))
	n.add_child(nOuest)
	
	var miPoteauNO=MeshInstance.new()
	miPoteauNO.scale=Vector3(0.01,1.0,0.01)
	miPoteauNO.translation=Vector3(-0.99,0.0,-0.99)
	var meshPoteauNO=CubeMesh.new()
	miPoteauNO.mesh=meshPoteauNO
	var matPoteauNO=SpatialMaterial.new()
	miPoteauNO.set_surface_material(0,matPoteauNO)
	matPoteauNO.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauNO)

	var miPoteauNE=MeshInstance.new()
	miPoteauNE.scale=Vector3(0.01,1.0,0.01)
	miPoteauNE.translation=Vector3(0.99,0.0,-0.99)
	var meshPoteauNE=CubeMesh.new()
	miPoteauNE.mesh=meshPoteauNE
	var matPoteauNE=SpatialMaterial.new()
	miPoteauNE.set_surface_material(0,matPoteauNE)
	matPoteauNE.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauNE)

	var miPoteauSE=MeshInstance.new()
	miPoteauSE.scale=Vector3(0.01,1.0,0.01)
	miPoteauSE.translation=Vector3(0.99,0.0,0.99)
	var meshPoteauSE=CubeMesh.new()
	miPoteauSE.mesh=meshPoteauSE
	var matPoteauSE=SpatialMaterial.new()
	miPoteauSE.set_surface_material(0,matPoteauSE)
	matPoteauSE.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauSE)

	var miPoteauSO=MeshInstance.new()
	miPoteauSO.scale=Vector3(0.01,1.0,0.01)
	miPoteauSO.translation=Vector3(-0.99,0.0,0.99)
	var meshPoteauSO=CubeMesh.new()
	miPoteauSO.mesh=meshPoteauSE
	var matPoteauSO=SpatialMaterial.new()
	miPoteauSO.set_surface_material(0,matPoteauSO)
	matPoteauSO.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauSO)
	
	var miMurNord=MeshInstance.new()
	miMurNord.rotation=Vector3(PI/2.0,0.0,0.0)
	var meshMurNord=PlaneMesh.new()
	miMurNord.mesh=meshMurNord
	var matMurNord=SpatialMaterial.new()
	miMurNord.set_surface_material(0,matMurNord)
	
	# We charge pictures automatically by there name and position in the environment
	if (file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(0)+".png")):
		matMurNord.albedo_texture=chargerImageCellule(pos, 0)
		nNord.add_child(miMurNord)
	# if a wall of a cell doesn't have a picture name we load the default picture 
	else: 
		if(lDestinations[0] == -1):
			matMurNord.albedo_texture=chargerImageDefault()
			nNord.add_child(miMurNord)

	var miMurEst=MeshInstance.new()
	miMurEst.rotation=Vector3(PI/2.0,-PI/2.0,0.0)
	var meshMurEst=PlaneMesh.new()
	miMurEst.mesh=meshMurEst
	var matMurEst=SpatialMaterial.new()
	miMurEst.set_surface_material(0,matMurEst)

	if (file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(1)+".png")):
			matMurEst.albedo_texture=chargerImageCellule(pos, 1)
			nEst.add_child(miMurEst)
	else: 
		if(lDestinations[1] == -1):
			matMurEst.albedo_texture=chargerImageDefault()
			nEst.add_child(miMurEst)
			
	var miMurSud=MeshInstance.new()
	miMurSud.rotation=Vector3(PI/2.0,-PI,0.0)
	var meshMurSud=PlaneMesh.new()
	miMurSud.mesh=meshMurSud
	var matMurSud=SpatialMaterial.new()
	miMurSud.set_surface_material(0,matMurSud)
	if (file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(2)+".png")):
		matMurSud.albedo_texture=chargerImageCellule(pos, 2)
		nSud.add_child(miMurSud)
	else:
		if(lDestinations[2] == -1):
			matMurSud.albedo_texture=chargerImageDefault()
			nSud.add_child(miMurSud)
			
	var miMurOuest=MeshInstance.new()
	miMurOuest.rotation=Vector3(PI/2.0,PI/2.0,0.0)
	var meshMurOuest=PlaneMesh.new()
	miMurOuest.mesh=meshMurOuest
	var matMurOuest=SpatialMaterial.new()
	miMurOuest.set_surface_material(0,matMurOuest)
	if (file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(3)+".png")):
		matMurOuest.albedo_texture=chargerImageCellule(pos, 3)
		nOuest.add_child(miMurOuest)
	else:
		if(lDestinations[3] == -1):
			matMurOuest.albedo_texture=chargerImageDefault()
			nOuest.add_child(miMurOuest)
		
	return [n,nNord,nEst,nSud,nOuest,lWalls,lDestinations,celluleBase,lCellules,porteAOuvrir,reponse,reponseAttendue]

func chargerImageCellule(n, i): 
	var it=ImageTexture.new()
	var listImageCellule = []
	var file2Check = File.new()
	
	if(i == 34):
		it.load("res://textures_mur/bitume.jpg")
	else:
		if (file2Check.file_exists("res://textures_mur/"+str(n)+"_"+str(i)+".png")):
			it.load("res://textures_mur/"+str(n)+"_"+str(i)+".png")
			
	return it
		
func chargerImageDefault():
	var it=ImageTexture.new()
	it.load("res://textures_mur/default.jpg")
	return it

func getDictMaze(): 
	return dictMaze

func getPos():
	return pos
