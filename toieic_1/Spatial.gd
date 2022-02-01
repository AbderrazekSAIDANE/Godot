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
	var l=creerCellule(0,0,[1,0,1,1],[0,1,2,3],[-1,1,-1,-1])
	add_child(l[0])
	dictMaze[0]=l
	l=creerCellule(2,0,[0,1,1,0],[0,1,2,3],[2,-1,-1,0])
	add_child(l[0])
	dictMaze[1]=l
	l=creerCellule(2,-2,[1,0,0,1],[0,1,2,3],[-1,3,1,-1])
	add_child(l[0])
	dictMaze[2]=l
	l=creerCellule(4,-2,[1,1,1,0],[0,1,2,3],[-1,-1,-1,2])
	add_child(l[0])
	dictMaze[3]=l


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
	it.load("res://textures_mur/brique1.jpg")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/brique2.jpg")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/brique3.jpg")
	lTextures_mur.append(it)
	it=ImageTexture.new()
	it.load("res://textures_mur/brique4.jpg")
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
	
	var miPoteauNO=MeshInstance.new()
	miPoteauNO.scale=Vector3(0.05,1.0,0.05)
	miPoteauNO.translation=Vector3(-0.95,0.0,-0.95)
	var meshPoteauNO=CubeMesh.new()
	miPoteauNO.mesh=meshPoteauNO
	var matPoteauNO=SpatialMaterial.new()
	miPoteauNO.set_surface_material(0,matPoteauNO)
	matPoteauNO.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauNO)

	var miPoteauNE=MeshInstance.new()
	miPoteauNE.scale=Vector3(0.05,1.0,0.05)
	miPoteauNE.translation=Vector3(0.95,0.0,-0.95)
	var meshPoteauNE=CubeMesh.new()
	miPoteauNE.mesh=meshPoteauNE
	var matPoteauNE=SpatialMaterial.new()
	miPoteauNE.set_surface_material(0,matPoteauNE)
	matPoteauNE.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauNE)

	var miPoteauSE=MeshInstance.new()
	miPoteauSE.scale=Vector3(0.05,1.0,0.05)
	miPoteauSE.translation=Vector3(0.95,0.0,0.95)
	var meshPoteauSE=CubeMesh.new()
	miPoteauSE.mesh=meshPoteauSE
	var matPoteauSE=SpatialMaterial.new()
	miPoteauSE.set_surface_material(0,matPoteauSE)
	matPoteauSE.albedo_color=Color(0.0,0.0,0.0,1.0)
	n.add_child(miPoteauSE)

	var miPoteauSO=MeshInstance.new()
	miPoteauSO.scale=Vector3(0.05,1.0,0.05)
	miPoteauSO.translation=Vector3(-0.95,0.0,0.95)
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
	
	return [n,nNord,nEst,nSud,nOuest,lDestinations]
	pass


func _on_Button_pressed():
	print("pressed")
	$AudioStreamPlayer.play()
	pass # Replace with function body.
	
func getDictMaze(): 
	return dictMaze
