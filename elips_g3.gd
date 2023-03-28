extends Node2D

export var radi := 21.0
var phabas := 0.0
var ramo := 0.0

func _process():
# use with care, may quickly fill video memory!
#  phabas += _delta
#  ramo = 0.5*radi*(1.0+sin(phabas))
  update()

func _draw():
  var gtrs := get_tree().root.size
  var per_row :int = gtrs.x / ramo
  var numeli :int = per_row*gtrs.y / ramo
  for e in numeli:
    var mo :int = e%3
    var place := Vector2(ramo*(e*per_row), ramo*(1+e/per_row))
    draw_ellipse(place, ramo, Color(1.0-mo/2.0, mo%2, mo/2.0), float(e)/numeli)

func draw_ellipse(center :Vector2, radi :float, fillcol :Color, elip := 1.0):
  var numpoi := 6 + int(radi/1.5)
  points := PoolVector2Array()
  var ap :float
  for p in range(numpoi):
    ap = TAU*p / numpoi
    points.push_back(center + Vector2(cos(ap), sin(ap)*elip)*radi)
  draw_colored_polygon(points, fillcol)


