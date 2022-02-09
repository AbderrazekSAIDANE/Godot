extends Spatial

var client # Used to send UDP messages to vosk application

var server # Used to receive UDP posts from vosk application  

var muted # Inform if we need to mute the microphone or no 

var lSons # sounds list 


var dictMaze # Important : this variable contains all the information needed to identify and create the cells

var pos # indicates the position of the player 

var dir # Indicates the direction or orientation of the player 

# Called when the node enters the scene tree for the first time.
func _ready():
	dictMaze={}
	pos=0
	dir=0
	$Control/Label.text="NORD"

	lSons=[] 
	chargerSons() # Load sounds

	# On affecte le son en fonction de la position pos courante
	$AudioStreamPlayer.stream=lSons[pos]
	
	# At the begging the microphone is muted 
	muted=0

	# On construit le labyrinthe avec une succession d'appels à creerCellule
	# Il y a 10 arguments à passer, résumés ici
	#
	# 0 / position en x
	# 1 / position en z
	# 2 / liste des murs 1 indique un mur, 0 pas de mur
	# 3 / liste des textures sur nord, est, sud, ouest
	# 4 / liste des cellules possibles à partir de cette cellule dans l'ordre N,E,S,O
	#    si -1, alors direction impossible
	# 5 / la cellule de base où se trouve la porte
	#    -1 pour la cellule de base, numero de la cellule sinon
	# 6 / la liste des cellules pour lesquelles il y a des questions devant être repondues
	# 7 / le numéro du mur où il y a une porte 0=N, 1=E, 2=S, 3=O
	# 8 / la réponse donnée par le joueur 0=A, 1=B, 2=C, 3=D
	# 9 / la réponse attendue 0=A, 1=B, 2=C, 3=D
	#
	# Voici ce que les 5 appels à creerCellule représentent ici
	#		4 - 2 - 3
	#		|   |
	#		0 - 1
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
	var l=creerCellule(0,0,[1,-1,-1,-1],3,[],-1,-1,1, 0)
	add_child(l[0])
	dictMaze[0]=l
	l=creerCellule(0,-2,[-1,2,0,-1],3,[],-1,-1,1, 1)
	add_child(l[0])
	dictMaze[1]=l
	l=creerCellule(2,-2,[3,-1,-1,1],3,[],-1,-1,2, 2)
	add_child(l[0])
	dictMaze[2]=l
	l=creerCellule(2,-4,[-1,-1,2,4],-1,[0,1,2],3,-1,-1, 3)
	add_child(l[0])
	dictMaze[3]=l
	#------------------ Deuxième Bloc --------------------#
	l=creerCellule(0,-4,[5,3,-1,-1],7,[],-1,-1,1, 4)
	add_child(l[0])
	dictMaze[4]=l
	l=creerCellule(0,-6,[6,-1,4,-1],7,[],-1,-1,1, 5)
	add_child(l[0])
	dictMaze[5]=l
	l=creerCellule(0,-8,[7,-1,5,-1],7,[],-1,-1,2, 6)
	add_child(l[0])
	dictMaze[6]=l
	l=creerCellule(0,-10,[8,-1,6,-1],-1,[4,5,6],3,-1,-1, 7)
	add_child(l[0])
	dictMaze[7]=l
	#------------------ Troisième Bloc --------------------#
	l=creerCellule(0,-12,[9,-1,7,-1],12,[],-1,-1,1, 8)
	add_child(l[0])
	dictMaze[8]=l
	l=creerCellule(0,-14,[-1,-1,8,10],12,[],-1,-1,1, 9)
	add_child(l[0])
	dictMaze[9]=l
	l=creerCellule(-2,-14,[11,9,-1,-1],12,[],-1,-1,2, 10)
	add_child(l[0])
	dictMaze[10]=l
	l=creerCellule(-2,-16,[-1,-1,10,12],12,[],3,-1,-1, 11)
	add_child(l[0])
	dictMaze[11]=l
	l=creerCellule(-4,-16,[13,11,-1,-1],-1,[8,9,10,11],3,-1,-1, 12)
	add_child(l[0])
	dictMaze[12]=l
	#------------------ Quatrième Bloc --------------------#
	l=creerCellule(-4,-18,[14,-1,12,-1],15,[],-1,-1,1, 13)
	add_child(l[0])
	dictMaze[13]=l
	l=creerCellule(-4,-20,[15,-1,13,-1],15,[],-1,-1,1, 14)
	add_child(l[0])
	dictMaze[14]=l
	l=creerCellule(-4,-22,[-1,16,14,-1],15,[],-1,-1,2, 15)
	add_child(l[0])
	dictMaze[15]=l
	#------------------ Cinquième Bloc --------------------#
	l=creerCellule(-2,-22,[-1,16,-1,15],19,[],-1,-1,1, 16)
	add_child(l[0])
	dictMaze[16]=l
	l=creerCellule(0,-22,[-1,18,-1,16],19,[],-1,-1,1, 17)
	add_child(l[0])
	dictMaze[17]=l
	l=creerCellule(2,-22,[-1,19,-1,17],19,[],-1,-1,2, 18)
	add_child(l[0])
	dictMaze[18]=l
	l=creerCellule(4,-22,[-1,-1,-1,18],-1,[16,17,18],3,-1,-1, 19)
	add_child(l[0])
	dictMaze[19]=l
	#------------------ Sixième Bloc --------------------#

	# Creation of the server on port 4242 
	server = UDPServer.new()
	# The server will always listen on the port 4242 waiting for someting from his clients
	server.listen(4242)
	# Creation of the clien to send messages on port 4243
	client= PacketPeerUDP.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# This function is called at every picture 
	
	# if this condition is verified : a sound is played and the microphone is muted
	# we send a UDP request to unmeted the vosk application  

	if $AudioStreamPlayer.playing==false and muted==1:
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Unmute".to_utf8())
		muted=0
		return
	
	
	# On regarde maintenant si un message UDP est arrivé. Si oui, on décode le mot
	# et on exécute la commande correspondante en examinant la première lettre du mot
	# 'f' = forward
	# 'r' = right
	# 'l' = left
	# 'p' = play
	# 'a' = réponse a
	# 'b' = réponse b
	# 'c' = réponse c
	# 'd' = réponse d
	
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
			elif (pktstr[0]=='a'):
				answer_a()
			elif (pktstr[0]=='b'):
				answer_b()
			elif (pktstr[0]=='c'):
				answer_c()
			elif (pktstr[0]=='d'):
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
	$Camera.rotation.y+=PI/2.0
	dir=dir-1
	if dir==-1:
		dir=3
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

# Pour tourner la caméra à droite, on fait faire une rotation de -PI/2 à la caméra
# et on ajuste la variable dir 0=N, 1=E, 2=S, 3=O
func turn_right():
	# Based on the trigonometric circle turn the camera right mean add -90° = -PI/2 to the y axe
	$Camera.rotation.y-=PI/2.0
	dir=dir+1
	if dir==4:
		dir=0
	setLabel()

# Pour faire avancer le joueur dans sa direction dir à partir de sa position pos, il faut
# récupérer lWalls, la liste des murs (0=pas de mur, 1=mur) et la liste des directions lDirections
# Ces listes sont accessibles aux positions 5 et 6 de la liste obtenue à partir de dictMaze[pos] 
func forward():
	#var lWalls=dictMaze[pos][5]
	#var lDirections=dictMaze[pos][6]
	# si il n'y a pas de mur dans la direction où on veut aller, alors le déplacement est valide
	#if lWalls[dir]==0:
	# déplacement vers 0=N, vers les z négatifs
	if (dir==0):
		$Camera.translation.z-=2
	# déplacement vers 1=E, vers les x positifs
	elif (dir==1):
		$Camera.translation.x+=2
	# déplacement vers 2=S, vers les z positifs
	elif (dir==2):
		$Camera.translation.z+=2
	# déplacement vers 3=O, vers les x négatifs
	elif (dir==3):
		$Camera.translation.x-=2
		# et on affecte pos avec la nouvelle direction
		#pos=lDirections[dir]

func backward():
	#var lDirections=dictMaze[pos][6]
	if (dir==0):
		print()
		$Camera.translation.z+=2
	elif (dir==1):
		$Camera.translation.x-=2
	elif (dir==2):
		$Camera.translation.z-=2
	elif (dir==3):
		$Camera.translation.x+=2
	#pos=lDirections[dir]
	
# Pour jouer un son. On joue. On mute.
func play():
	$AudioStreamPlayer.stream=lSons[pos]
	$AudioStreamPlayer.play()
	client.connect_to_host("127.0.0.1", 4243)
	client.put_packet("Mute".to_utf8())
	muted=1

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

# Fonction permettant d'affecter une valeur de réponse à une cellule
# C'est ici que l'on regarde si le fait d'avoir répondu à une question ouvre ou non
# une porte
func checkAnswer(r):
	# L'élément 7 de la liste dictMaze[pos] représente la valeur de la cellule de base.
	# La cellule qui contient la porte n'a pas de cellule de base, donc a une valeur de -1
	# Dans notre exemple, la cellule 0 est celle qui contient une porte au nord, sa valeur
	# de cellule de base contient donc -1.
	# Les 3 questions associées à l'ouverture de cette porte sont situées aux cellules 1,2,3
	# rassemblées dans la liste des numéros des cellules [1,2,3]
	var celluleBase=dictMaze[pos][7]
	var lCellules=dictMaze[celluleBase][8]
	#
	# L'élément 10 de la liste dictMaze[pos] contient au départ -1, pour indiquer que le joueur
	# n'a pas encore répondu à la question en ce lieu pos. On affecte donc cet élément de liste
	# avec la réponse r du joueur
	dictMaze[pos][10]=r
	#
	# On considère que la porte est par défaut ouverte
	var okPourOuvrir=true
	# et on parcourt la liste des cellules associées à la cellule de base
	for c in lCellules:
		# soit cell une de ces cellules de numéro 1,2,3 dans notre exemple
		var cell=dictMaze[c]
		# si la valeur entrée par le joueur pour cette cellule (position 10)
		# n'est pas égal à la valeur attendue (position11) alors la porte ne peut s'ouvrir
		if cell[10]!=cell[11]:
			okPourOuvrir=false
	# Si toutes les cellules permettant d'ouvir la porte ont des réponses correctes
	if (okPourOuvrir==true):
		# on récupère la liste pour la cellule de base
		var b=dictMaze[celluleBase]
		# on récupère l'indice du mur où se trouve la porte (0=N, 1=E, 2=S, 3=O)
		var porteAouvrir=b[9]
		# Si il s'agit d'une porte au nord, on cache le mur nord, et on modifie la liste des murs
		# pour créer une ouverture en mettant 0 au bon endroit dans la liste
		if (porteAouvrir==0):
			b[1].hide()
			b[5][0]=0
		elif (porteAouvrir==1):
			b[2].hide()
			b[5][1]=0
		elif (porteAouvrir==2):
			b[3].hide()
			b[5][2]=0
		elif (porteAouvrir==3):
			b[4].hide()
			b[5][3]=0
	
func chargerTextures():
	pass
	print("Textures chargées")

func chargerSons():
	var s=load("res://sons/statement.wav")
	lSons.append(s)
	s=load("res://sons/q1.wav")
	lSons.append(s)
	s=load("res://sons/q2.wav")
	lSons.append(s)
	s=load("res://sons/q3.wav")
	lSons.append(s)
	s=load("res://sons/q4.wav")
	lSons.append(s)
	print("Sons chargés")
	
func creerCellule(x,z,lDestinations,celluleBase,lCellules,porteAOuvrir,reponse,reponseAttendue, pos):
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
	
	var file2Check = File.new()

	var miMurNord=MeshInstance.new()
	miMurNord.rotation=Vector3(PI/2.0,0.0,0.0)
	var meshMurNord=PlaneMesh.new()
	miMurNord.mesh=meshMurNord
	var matMurNord=SpatialMaterial.new()
	miMurNord.set_surface_material(0,matMurNord)
	
	if (file2Check.file_exists("res://textures_mur/"+str(pos)+"_"+str(0)+".png")):
		matMurNord.albedo_texture=chargerImageCellule(pos, 0)
		nNord.add_child(miMurNord)
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
	#miMurNord.scale=Vector3(0.05,1.0,0.05)
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
		
	var lWalls
	
	# On construit une liste très importante que l'on va ranger dans un dictionnaire
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
