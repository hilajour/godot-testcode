extends Spatial

var cam := Camera.new()
var mult := 6
var part := 3
var pari := []
const shadercode := 'shader_type spatial;varying vec4 ic;void vertex(){ic=INSTANCE_CUSTOM;}void fragment(){ALBEDO=ic.rgb;ALPHA=ic.a;}'

func _ready():
	cam.transform.origin += Vector3.BACK*PI
	add_child(cam)
	add_mu(part)

func add_mu(var numu :int):
	for n in numu:
		var pati := MultiMeshInstance.new()
		var pamum := MultiMesh.new()
		pamum.transform_format = MultiMesh.TRANSFORM_3D
		pamum.custom_data_format = MultiMesh.CUSTOM_DATA_FLOAT
		pamum.mesh = SphereMesh.new()
		pamum.mesh.rings = 16
		pamum.mesh.radial_segments = pamum.mesh.rings*2
		pamum.instance_count = mult
		var ti = Transform.IDENTITY
		for i in mult:
			var ang := float(i)*TAU/6.0
			var ca := cos(ang)
			var sa := sin(ang)
			ti.origin = Vector3(ca, sa, 0)
			pamum.set_instance_transform(i, ti)
			pamum.set_instance_custom_data(i, Color(ca, sa, sa/ca, 0.3))
		pati.multimesh = pamum
		var pash := ShaderMaterial.new()
		pash.shader = Shader.new()
		pash.shader.code = shadercode
		pati.material_override = pash
		pati.set_as_toplevel(true)
		pari.append(pati)
		add_child(pati)

var speed := 3.0
func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		cam.transform.origin += Vector3.FORWARD*delta*speed
	if Input.is_action_pressed("ui_down"):
		cam.transform.origin += Vector3.BACK*delta*speed
	if Input.is_action_pressed("ui_left"):
		rotation.y += delta*speed
	if Input.is_action_pressed("ui_right"):
		rotation.y -= delta*speed
	for p in pari.size():
		pari[p].rotation.x += (p+TAU)*delta*.62
		pari[p].rotation.y += (p+TAU)*delta*.7
