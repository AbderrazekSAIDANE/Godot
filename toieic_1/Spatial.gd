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
	chargerTextures()
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
	#
	#
	#                      murs      textures  desinations
	var l=creerCellule(0,0,[1,0,1,1,1],[0,0,0,0,34],[-1,1,-1,-1])
	add_child(l[0])
	dictMaze[0]=l
	
	l=creerCellule(2,0,[1,0,1,0,1],[0,0,0,0,34],[-1,2,-1,0])
	add_child(l[0])
	dictMaze[1]=l
	
	l=creerCellule(4,0,[0,0,1,0,1],[0,0,0,0,35],[3,12,-1,1])
	add_child(l[0])
	dictMaze[2]=l
	
	l=creerCellule(4,-2,[0,1,0,1,1],[0,35,0,0,34],[4,-1,2,-1])
	add_child(l[0])
	dictMaze[3]=l
	
	l=creerCellule(4,-4,[0,0,0,0,1],[0,0,0,0,34],[7,9,3,5])
	add_child(l[0])
	dictMaze[4]=l
	
	l=creerCellule(2,-4,[1,0,1,0,1],[0,0,0,0,34],[-1,4,-1,6])
	add_child(l[0])
	dictMaze[5]=l
	
	l=creerCellule(0,-4,[1,0,1,1,1],[1,0,2,3,34],[-1,5,-1,-1])
	add_child(l[0])
	dictMaze[6]=l
	
	l=creerCellule(4,-6,[0,1,0,1,1],[0,0,0,0,34],[8,-1,4,-1])
	add_child(l[0])
	dictMaze[7]=l
	
	l=creerCellule(4,-8,[1,1,0,1,1],[4,5,0,6,34],[-1,-1,7,-1])
	add_child(l[0])
	dictMaze[8]=l
	
	l=creerCellule(6,-4,[1,0,1,0,1],[0,0,0,0,34],[-1,10,-1,4])
	add_child(l[0])
	dictMaze[9]=l
	
	l=creerCellule(8,-4,[0,1,1,0,1],[0,0,0,0,34],[11,-1,-1,9])
	add_child(l[0])
	dictMaze[10]=l
	
	l=creerCellule(8,-6,[1,1,0,1,1],[7,8,0,9,34],[-1,-1,10,-1])
	add_child(l[0])
	dictMaze[11]=l
	
	l=creerCellule(6,0,[1,0,0,0,1],[0,0,0,0,36],[-1,19,13,2])
	add_child(l[0])
	dictMaze[12]=l
	
	l=creerCellule(6,2,[0,1,0,1,1],[0,0,0,0,34],[12,-1,14,-1])
	add_child(l[0])
	dictMaze[13]=l
	
	l=creerCellule(6,4,[0,0,1,0,1],[0,0,0,0,34],[13,17,-1,15])
	add_child(l[0])
	dictMaze[14]=l
	
	l=creerCellule(4,4,[1,0,1,0,1],[0,0,0,0,34],[-1,14,-1,16])
	add_child(l[0])
	dictMaze[15]=l
	
	l=creerCellule(2,4,[1,0,1,1,1],[10,0,11,12,34],[-1,15,-1,-1])
	add_child(l[0])
	dictMaze[16]=l
	
	l=creerCellule(8,4,[1,0,1,0,1],[0,0,0,0,34],[-1,18,-1,14])
	add_child(l[0])
	dictMaze[17]=l
	
	l=creerCellule(10,4,[1,1,1,0,1],[13,14,15,0,34],[-1,-1,-1,17])
	add_child(l[0])
	dictMaze[18]=l
	
	l=creerCellule(8,0,[1,0,1,0,1],[0,0,0,0,34],[-1,20,-1,12])
	add_child(l[0])
	dictMaze[19]=l
	
	l=creerCellule(10,0,[1,0,1,0,1],[0,0,0,0,34],[-1,21,-1,19])
	add_child(l[0])
	dictMaze[20]=l
	
	l=creerCellule(12,0,[0,0,1,0,1],[0,0,0,0,34],[22,24,-1,20])
	add_child(l[0])
	dictMaze[21]=l
	
	l=creerCellule(12,-2,[0,1,0,1,1],[0,0,0,0,34],[23,-1,21,-1])
	add_child(l[0])
	dictMaze[22]=l
	
	l=creerCellule(12,-4,[1,1,0,1,1],[16,17,0,18,34],[-1,-1,22,-1])
	add_child(l[0])
	dictMaze[23]=l
	
	l=creerCellule(14,0,[1,0,1,0,1],[0,0,0,0,34],[-1,25,-1,21])
	add_child(l[0])
	dictMaze[24]=l
	
	l=creerCellule(16,0,[0,0,1,0,1],[0,0,0,0,34],[26,32,-1,24])
	add_child(l[0])
	dictMaze[25]=l
	
	l=creerCellule(16,-2,[0,1,0,1,1],[0,0,0,0,34],[27,-1,25,-1])
	add_child(l[0])
	dictMaze[26]=l
	
	l=creerCellule(16,-4,[1,0,0,1,1],[0,0,0,0,34],[-1,28,26,-1])
	add_child(l[0])
	dictMaze[27]=l
	
	l=creerCellule(18,-4,[0,0,1,0,1],[0,0,0,0,34],[30,29,-1,27])
	add_child(l[0])
	dictMaze[28]=l
	
	l=creerCellule(20,-4,[1,1,1,0,1],[19,20,21,0,34],[-1,-1,-1,28])
	add_child(l[0])
	dictMaze[29]=l
	
	l=creerCellule(18,-6,[0,1,0,1,1],[0,0,0,0,34],[31,-1,28,-1])
	add_child(l[0])
	dictMaze[30]=l
	
	l=creerCellule(18,-8,[1,1,0,1,1],[22,23,0,24,34],[-1,-1,30,-1])
	add_child(l[0])
	dictMaze[31]=l
	
	l=creerCellule(18,0,[1,1,0,0,1],[0,0,0,0,34],[-1,-1,33,25])
	add_child(l[0])
	dictMaze[32]=l
	
	l=creerCellule(18,2,[0,1,0,1,1],[0,0,0,0,34],[32,-1,34,-1])
	add_child(l[0])
	dictMaze[33]=l
	
	l=creerCellule(18,4,[0,0,0,0,1],[0,0,0,0,34],[33,39,35,37])
	add_child(l[0])
	dictMaze[34]=l
	
	l=creerCellule(18,6,[0,1,0,1,1],[0,0,0,0,34],[34,-1,36,-1])
	add_child(l[0])
	dictMaze[35]=l
	
	l=creerCellule(18,8,[0,1,1,1,1],[0,25,26,27,34],[35,-1,-1,-1])
	add_child(l[0])
	dictMaze[36]=l
	
	l=creerCellule(16,4,[1,0,1,0,1],[0,0,0,0,34],[-1,34,-1,38])
	add_child(l[0])
	dictMaze[37]=l
	
	l=creerCellule(14,4,[1,0,1,1,1],[28,0,29,30,34],[-1,37,-1,-1])
	add_child(l[0])
	dictMaze[38]=l
	
	l=creerCellule(20,4,[1,0,1,0,1],[0,0,0,0,34],[-1,40,-1,34])
	add_child(l[0])
	dictMaze[39]=l
	
	l=creerCellule(22,4,[1,1,1,0,1],[31,32,33,0,34],[-1,-1,-1,39])
	add_child(l[0])
	dictMaze[40]=l

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
	var it=ImageTexture.new()
	it.load("res://textures_mur/default.jpg")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/6_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/6_2.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/6_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/8_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/8_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/8_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/11_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/11_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/11_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/16_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/16_2.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/16_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/18_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/18_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/18_2.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/23_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/23_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/23_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/29_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/29_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/29_2.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/31_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/31_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/31_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/36_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/36_2.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/36_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/38_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/38_2.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/38_3.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/40_0.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/40_1.png")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/40_2.png")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/bitume.jpg")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/NY.jpg")
	lTextures_mur.append(it)
	
	it=ImageTexture.new()
	it.load("res://textures_mur/LV.jpg")
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
	
func creerCellule(x,z,lWalls,lTextureNumbers,lDestinations):
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
	
	if (lWalls[0]==1):
		var miMurNord=MeshInstance.new()
		#miMurNord.scale=Vector3(0.05,1.0,0.05)
		miMurNord.rotation=Vector3(PI/2.0,0.0,0.0)
		var meshMurNord=PlaneMesh.new()
		miMurNord.mesh=meshMurNord
		var matMurNord=SpatialMaterial.new()
		miMurNord.set_surface_material(0,matMurNord)
		matMurNord.albedo_texture=lTextures_mur[lTextureNumbers[0]]
		nNord.add_child(miMurNord)

	if (lWalls[1]==1):
		var miMurEst=MeshInstance.new()
		#miMurNord.scale=Vector3(0.05,1.0,0.05)
		miMurEst.rotation=Vector3(PI/2.0,-PI/2.0,0.0)
		var meshMurEst=PlaneMesh.new()
		miMurEst.mesh=meshMurEst
		var matMurEst=SpatialMaterial.new()
		miMurEst.set_surface_material(0,matMurEst)
		matMurEst.albedo_texture=lTextures_mur[lTextureNumbers[1]]
		nEst.add_child(miMurEst)

	if (lWalls[2]==1):
		var miMurSud=MeshInstance.new()
		#miMurNord.scale=Vector3(0.05,1.0,0.05)
		miMurSud.rotation=Vector3(PI/2.0,-PI,0.0)
		var meshMurSud=PlaneMesh.new()
		miMurSud.mesh=meshMurSud
		var matMurSud=SpatialMaterial.new()
		miMurSud.set_surface_material(0,matMurSud)
		matMurSud.albedo_texture=lTextures_mur[lTextureNumbers[2]]
		nSud.add_child(miMurSud)

	if (lWalls[3]==1):
		var miMurOuest=MeshInstance.new()
		#miMurNord.scale=Vector3(0.05,1.0,0.05)
		miMurOuest.rotation=Vector3(PI/2.0,PI/2.0,0.0)
		var meshMurOuest=PlaneMesh.new()
		miMurOuest.mesh=meshMurOuest
		var matMurOuest=SpatialMaterial.new()
		miMurOuest.set_surface_material(0,matMurOuest)
		matMurOuest.albedo_texture=lTextures_mur[lTextureNumbers[3]]
		nOuest.add_child(miMurOuest)
		
	if(lWalls[4] == 1):
		var miRoute = MeshInstance.new()
		miRoute.rotation = Vector3(0.0,-PI/2,0.0)
		var meshRoute = PlaneMesh.new()
		miRoute.mesh = meshRoute
		var matRoute = SpatialMaterial.new()
		miRoute.set_surface_material(0,matRoute)
		matRoute.albedo_texture=lTextures_mur[lTextureNumbers[4]]
		route.add_child(miRoute)
		
		
	
	return [n,nNord,nEst,nSud,nOuest,lDestinations]
	pass


func _on_Button_pressed():
	print("pressed")
	$AudioStreamPlayer.play()
	pass # Replace with function body.
	
func getDictMaze(): 
	return dictMaze
