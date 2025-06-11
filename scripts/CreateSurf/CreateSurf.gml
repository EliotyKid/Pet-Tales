function CreateSurf(_pos, _size, _setDraw = function(){}, _delay=0) constructor{
  x = _pos.x
  y = _pos.y
  w = _size.x
  h = _size.y
  surf = surface_create(w,h)
  
  
  scaleCurve = new CurveRunner(acUi,"UIScale",1)
  angleCurve = new CurveRunner(acUi,"angle",1)
  
  scale = new Vector2(0,0)
  
  angle = 0
  
  delay = _delay
  timerDelay = 0
  
  setDraw = _setDraw
  
  Redraw = function(){
    if surface_exists(surf){
      surface_set_target(surf)
      draw_clear_alpha(c_black,0)
      script_execute(setDraw)
      surface_reset_target()
    }
  }
  
  Redraw()
  
  Update = function(){
    if timerDelay < delay {
      timerDelay ++
      return
    }
    
    var _scl = scaleCurve.getValue()
    scale = new Vector2(_scl,_scl)
    
    var _ang = angleCurve.getValue()
    angle = 20*_ang
  }
  
  Draw = function(){
    if surface_exists(surf){
      var _mat = matrix_build(x,y,0,0,0,angle,scale.x,scale.y,0)
      matrix_set(matrix_world,_mat)
      draw_surface(surf,-w*.5,-h*.5)
      matrix_set(matrix_world,matrix_build_identity())
    }
  }
  
  Clear = function(){
    if surface_exists(surf) surface_free(surf)
  }
  
  ResetAnimations = function(){
    timerDelay = 0
    scaleCurve.reset()
    angleCurve.reset()
    scale = new Vector2(0,0)
  }
  
}