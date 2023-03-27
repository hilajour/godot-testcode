extends Node3D

var nummul := 3
var numsph := 6
var cam := Camera3D.new()

func _ready():
	cam.translate(Vector3.BACK*2.5)
	add_child(cam)
#	add_child(DirectionalLight3D.new())
	for m in nummul:
		var mume := MultiMesh.new()
		mume.transform_format = MultiMesh.TRANSFORM_3D
		mume.use_custom_data = true
		mume.instance_count = numsph
		mume.mesh = SphereMesh.new()
		var ti := Transform3D.IDENTITY
		var tp := TAU/6.0
		for i in numsph:
			var ang := i*tp
			mume.set_instance_transform(i, ti.translated(Vector3(cos(ang), sin(ang), 0)))
		var mat := StandardMaterial3D.new()
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat.no_depth_test = true
		mat.albedo_color = Color(Color.WHITE, 0.5)
		mat.emission_enabled = true
		var mf := m%3
		mat.emission = Color(1.0-mf/2.0, mf%2, mf/2.0)
		var muin := MultiMeshInstance3D.new()
		muin.material_override = mat
		muin.rotate_y(m*tp*2)
		muin.multimesh = mume
		muin.top_level = true
		add_child(muin)

var roar := 0.0
func _process(delta):
	roar += delta
	rotation.y += delta
	cam.rotation.z += cos(roar)-sin(roar*0.7)
