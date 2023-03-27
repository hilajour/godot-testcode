extends Node3D

var cam := Camera3D.new()

func _ready():
	var mi := MeshInstance3D.new()
	mi.lod_bias = 0.05
	var prim := TorusMesh.new()
	mi.mesh = makelodmesh(prim.get_mesh_arrays())
	mi.rotate_x(PI/4)
	mi.rotate_z(PI/4)
	add_child(mi)
	cam.translate(Vector3.BACK*2)
	add_child(cam)
	add_child(DirectionalLight3D.new())

func makelodmesh(arrays :Array) -> ArrayMesh:
	var im := ImporterMesh.new()
	im.add_surface(Mesh.PRIMITIVE_TRIANGLES, arrays)
	im.generate_lods(5.0, 0.6, [])
#	for l in im.get_surface_lod_count(0):
#		prints("lod", l, "size:", im.get_surface_lod_size(0, l), "indices:", im.get_surface_lod_indices(0, l).size())
	return im.get_mesh()

func _process(delta):
	if Input.is_action_pressed('ui_up'):
		cam.translate(Vector3.FORWARD*.1)
	if Input.is_action_pressed('ui_down'):
		cam.translate(Vector3.BACK*.1)
