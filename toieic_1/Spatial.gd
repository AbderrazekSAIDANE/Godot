extends Spatial

var client
var server
var muted
var peers
var lTextures_mur
var lSons
var dictMaze
var pos
var idxRecord
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	dictMaze={}
	lTextures_mur=[]
	lSons=[]
	pos=0
	#chargerTextures()
	chargerSons()
	$AudioStreamPlayer.stream=lSons[pos]
	var array=AudioServer.capture_get_device_list()
	print(array)
	idxRecord = AudioServer.capture_get_device()
	print("idxRecord=",idxRecord)
	print("get_bus_count=",AudioServer.get_bus_count())
	print("get_bus_name=",AudioServer.get_bus_name(0))
	muted=0
	#
	#
	#                      murs      textures  desinations
	var l=creerCellule(0,0,[-1,1,-1,-1], 0)
	add_child(l[0])
	dictMaze[0]=l
	
	l=creerCellule(2,0,[-1,2,-1,0], 1)
	add_child(l[0])
	dictMaze[1]=l
	
	l=creerCellule(4,0,[3,12,-1,1], 2)
	add_child(l[0])
	dictMaze[2]=l
	
	l=creerCellule(4,-2,[4,-1,2,-1], 3)
	add_child(l[0])
	dictMaze[3]=l
	
	l=creerCellule(4,-4,[7,9,3,5], 4)
	add_child(l[0])
	dictMaze[4]=l
	
	l=creerCellule(2,-4,[-1,4,-1,6], 5)
	add_child(l[0])
	dictMaze[5]=l
	
	l=creerCellule(0,-4,[-1,5,-1,-1], 6)
	add_child(l[0])
	dictMaze[6]=l
	
	l=creerCellule(4,-6,[8,-1,4,-1], 7)
	add_child(l[0])
	dictMaze[7]=l
	
	l=creerCellule(4,-8,[-1,-1,7,-1], 8)
	add_child(l[0])
	dictMaze[8]=l
	
	l=creerCellule(6,-4,[-1,10,-1,4], 9)
	add_child(l[0])
	dictMaze[9]=l
	
	l=creerCellule(8,-4,[11,-1,-1,9], 10)
	add_child(l[0])
	dictMaze[10]=l
	
	l=creerCellule(8,-6,[-1,-1,10,-1], 11)
	add_child(l[0])
	dictMaze[11]=l
	
	l=creerCellule(6,0,[-1,19,13,2], 12)
	add_child(l[0])
	dictMaze[12]=l
	
	l=creerCellule(6,2,[12,-1,14,-1], 13)
	add_child(l[0])
	dictMaze[13]=l
	
	l=creerCellule(6,4,[13,17,-1,15], 14)
	add_child(l[0])
	dictMaze[14]=l
	
	l=creerCellule(4,4,[-1,14,-1,16],15)
	add_child(l[0])
	dictMaze[15]=l
	
	l=creerCellule(2,4,[-1,15,-1,-1], 16)
	add_child(l[0])
	dictMaze[16]=l
	
	l=creerCellule(8,4,[-1,18,-1,14], 17)
	add_child(l[0])
	dictMaze[17]=l
	
	l=creerCellule(10,4,[-1,-1,-1,17], 18)
	add_child(l[0])
	dictMaze[18]=l
	
	l=creerCellule(8,0,[-1,20,-1,12], 19)
	add_child(l[0])
	dictMaze[19]=l
	
	l=creerCellule(10,0,[-1,21,-1,19], 20)
	add_child(l[0])
	dictMaze[20]=l
	
	l=creerCellule(12,0,[22,24,-1,20], 21)
	add_child(l[0])
	dictMaze[21]=l
	
	l=creerCellule(12,-2,[23,-1,21,-1], 22)
	add_child(l[0])
	dictMaze[22]=l
	
	l=creerCellule(12,-4,[-1,-1,22,-1], 23)
	add_child(l[0])
	dictMaze[23]=l
	
	l=creerCellule(14,0,[-1,25,-1,21], 24)
	add_child(l[0])
	dictMaze[24]=l
	
	l=creerCellule(16,0,[26,32,-1,24], 25)
	add_child(l[0])
	dictMaze[25]=l
	
	l=creerCellule(16,-2,[27,-1,25,-1], 26)
	add_child(l[0])
	dictMaze[26]=l
	
	l=creerCellule(16,-4,[-1,28,26,-1], 27)
	add_child(l[0])
	dictMaze[27]=l
	
	l=creerCellule(18,-4,[30,29,-1,27], 28)
	add_child(l[0])
	dictMaze[28]=l
	
	l=creerCellule(20,-4,[-1,-1,-1,28], 29)
	add_child(l[0])
	dictMaze[29]=l
	
	l=creerCellule(18,-6,[31,-1,28,-1], 30)
	add_child(l[0])
	dictMaze[30]=l
	
	l=creerCellule(18,-8,[-1,-1,30,-1], 31)
	add_child(l[0])
	dictMaze[31]=l
	
	l=creerCellule(18,0,[-1,41,33,25], 32)
	add_child(l[0])
	dictMaze[32]=l
	
	l=creerCellule(18,2,[32,-1,34,-1], 33)
	add_child(l[0])
	dictMaze[33]=l
	
	l=creerCellule(18,4,[33,39,35,37], 34)
	add_child(l[0])
	dictMaze[34]=l
	
	l=creerCellule(18,6,[34,-1,36,-1], 35)
	add_child(l[0])
	dictMaze[35]=l
	
	l=creerCellule(18,8,[35,-1,-1,-1], 36)
	add_child(l[0])
	dictMaze[36]=l
	
	l=creerCellule(16,4,[-1,34,-1,38], 37)
	add_child(l[0])
	dictMaze[37]=l
	
	l=creerCellule(14,4,[-1,37,-1,-1], 38)
	add_child(l[0])
	dictMaze[38]=l
	
	l=creerCellule(20,4,[-1,40,-1,34], 39)
	add_child(l[0])
	dictMaze[39]=l
	
	l=creerCellule(22,4,[-1,-1,-1,39], 40)
	add_child(l[0])
	dictMaze[40]=l
	
	l=creerCellule(20, 0,[-1, 42, -1, 32], 41)
	add_child(l[0])
	dictMaze[41] = l

	l=creerCellule(22, 0,[-1, 43, -1, 41], 42)
	add_child(l[0])
	dictMaze[42] = l

	l=creerCellule(24, 0,[-1, 44, -1, 42], 43)
	add_child(l[0])
	dictMaze[43] = l

	l=creerCellule(26, 0,[45, 53, -1, 43], 44)
	add_child(l[0])
	dictMaze[44] = l

	l=creerCellule(26, -2,[46, -1, 44, -1], 45)
	add_child(l[0])
	dictMaze[45] = l

	l=creerCellule(26, -4,[47, 51, 45, 50], 46)
	add_child(l[0])
	dictMaze[46] = l

	l=creerCellule(26, -6,[48, -1, 46, -1], 47)
	add_child(l[0])
	dictMaze[47] = l

	l=creerCellule(26, -8,[-1, -1, 47, -1], 48)
	add_child(l[0])
	dictMaze[48] = l

	l=creerCellule(22, -4,[-1, 50, -1, -1], 49)
	add_child(l[0])
	dictMaze[49] = l

	l=creerCellule(24, -4,[-1, 46, -1, 49], 50)
	add_child(l[0])
	dictMaze[50] = l

	l=creerCellule(28, -4,[-1, 52, -1, 46], 51)
	add_child(l[0])
	dictMaze[51] = l

	l=creerCellule(30, -4,[-1, -1, -1, 51], 52)
	add_child(l[0])
	dictMaze[52] = l

	l=creerCellule(28, 0, [-1, 60, 54, 44], 53)
	add_child(l[0])
	dictMaze[53] = l

	l=creerCellule(28, 2,[53, -1, 55, -1], 54)
	add_child(l[0])
	dictMaze[54] = l

	l=creerCellule(28, 4,[54, 58, -1, 56], 55)
	add_child(l[0])
	dictMaze[55] = l

	l=creerCellule(26, 4,[-1, 55, -1, 57], 56)
	add_child(l[0])
	dictMaze[56] = l

	l=creerCellule(24, 4,[-1, 56, -1, -1], 57)
	add_child(l[0])
	dictMaze[57] = l

	l=creerCellule(30, 4,[-1, 59, -1, 55], 58)
	add_child(l[0])
	dictMaze[58] = l

	l=creerCellule(32, 4,[-1, -1, -1, 58], 59)
	add_child(l[0])
	dictMaze[59] = l

	l=creerCellule(30, 0,[-1, 61, -1, 53], 60)
	add_child(l[0])
	dictMaze[60] = l

	l=creerCellule(32, 0,[-1, 62, -1, 60], 61)
	add_child(l[0])
	dictMaze[61] = l

	l=creerCellule(34, 0,[63, 65, -1, 61], 62)
	add_child(l[0])
	dictMaze[62] = l

	l=creerCellule(34, -2,[64, -1, 62, -1], 63)
	add_child(l[0])
	dictMaze[63] = l

	l=creerCellule(34, -4,[-1, -1, 63, -1], 64)
	add_child(l[0])
	dictMaze[64] = l

	l=creerCellule(36, 0, [-1, 66, -1, 62], 65)
	add_child(l[0])
	dictMaze[65] = l

	l=creerCellule(38, 0,[67, 73, -1, 65], 66)
	add_child(l[0])
	dictMaze[66] = l

	l=creerCellule(38, -2,[68, -1, 66, -1], 67)
	add_child(l[0])
	dictMaze[67] = l

	l=creerCellule(38, -4,[-1, 69, 67, -1], 68)
	add_child(l[0])
	dictMaze[68] = l

	l=creerCellule(40, -4,[70, 72, -1, 68], 69)
	add_child(l[0])
	dictMaze[69] = l

	l=creerCellule(40, -6,[71, -1, 69, -1], 70)
	add_child(l[0])
	dictMaze[70] = l

	l=creerCellule(40, -8,[-1, -1, 70, -1], 71)
	add_child(l[0])
	dictMaze[71] = l

	l=creerCellule(42, -4,[-1, -1, -1, 69], 72)
	add_child(l[0])
	dictMaze[72] = l

	l=creerCellule(40, 0,[-1, -1, 74, 66], 73)
	add_child(l[0])
	dictMaze[73] = l

	l=creerCellule(40, 2,[73, -1, 75, -1], 74)
	add_child(l[0])
	dictMaze[74] = l

	l=creerCellule(40, 4, [74, 77, -1, 76], 75)
	add_child(l[0])
	dictMaze[75] = l

	l=creerCellule(38, 4,[-1, 75, -1, -1], 76)
	add_child(l[0])
	dictMaze[76] = l

	l=creerCellule(42, 4,[-1, -1, -1, 75], 77)
	add_child(l[0])
	dictMaze[77] = l

	server = UDPServer.new()
	peers = []
	server.listen(4242)
	client= PacketPeerUDP.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $AudioStreamPlayer.playing==false and muted==1:
		client.connect_to_host("127.0.0.1", 4243)
		client.put_packet("Unmute".to_utf8())
		muted=0
		return
		
	server.poll() # Important!
	if server.is_connection_available():
		var peer : PacketPeerUDP = server.take_connection()
		var pkt = peer.get_packet()
		print("Accepted peer: %s:%s" % [peer.get_packet_ip(), peer.get_packet_port()])
		var pktstr=pkt.get_string_from_utf8()
		print(len(pktstr)," ",pktstr)
		var dir=$Camera.get_dir()
		print ("process=",dir)
		if (len(pktstr)>0):
			#if (pktstr[0]=='b'):
			#	$Camera.backward()
			if (pktstr[0]=='f'):
				var l5=dictMaze[pos][5]
				if l5[dir]>=0:
					$Camera.forward()
					pos=l5[dir]
					$AudioStreamPlayer.stream=lSons[pos]
				else:
					$AudioStreamPlayer2.play()
					print("bonk")
			if (pktstr[0]=='r'):
				$Camera.turn_right()
			elif (pktstr[0]=='l'):
				$Camera.turn_left()
			elif (pktstr[0]=='p'):
				$AudioStreamPlayer.play()
				client.connect_to_host("127.0.0.1", 4243)
				client.put_packet("Mute".to_utf8())
				muted=1
			elif (pktstr[0]=='a'):
				print("Answer a")
			elif (pktstr[0]=='b'):
				print("Answer b")
			elif (pktstr[0]=='c'):
				print("Answer c")
			elif (pktstr[0]=='d'):
				print("Answer d")
#	pass

func chargerTextures():
	pass
	var it=ImageTexture.new()
	it.load("res://textures_mur/default.jpg")
	lTextures_mur.append(it)
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
	
func creerCellule(x,z,lDestinations, pos):
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
	
	var route =Spatial.new()
	route.translate(Vector3(0.0,-1.0,0.0))
	n.add_child(route)
	
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
		
		
	var miRoute = MeshInstance.new()
	miRoute.rotation = Vector3(0.0,-PI/2,0.0)
	var meshRoute = PlaneMesh.new()
	miRoute.mesh = meshRoute
	var matRoute = SpatialMaterial.new()
	miRoute.set_surface_material(0,matRoute)
	matRoute.albedo_texture=chargerImageCellule(pos, 34)
	route.add_child(miRoute)
		
		
	
	return [n,nNord,nEst,nSud,nOuest,lDestinations]
	pass


func _on_Button_pressed():
	print("pressed")
	$AudioStreamPlayer.play()
	pass # Replace with function body.
	
func getDictMaze(): 
	return dictMaze

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
	
	
	
	
	
