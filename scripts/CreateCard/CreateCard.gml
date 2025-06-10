function CreateCard(_pet) constructor {
  var _screen = GetScreenSize()
  x = _screen.w*.5
  y = _screen.h*1.5
  dest = new Vector2(300,300)
  
  pet = _pet
  
  w = 250
  h = 250
  marg = 25
  
  angle = 0
  scale = new Vector2(1,1)
  
  surf = surface_create(w,h)
  
  hover = false
  
  if surface_exists(surf){
    surface_set_target(surf)
    draw_clear_alpha(c_black,0)
    DrawBox("w",marg,marg,w-marg*2,h-marg*2,UI_SCALE)
    
    var _centerPos = new Vector2(w*.5,h*.5)
    
    var _s = 7
    draw_sprite_ext(pet.sprite.idle,0,_centerPos.x,_centerPos.y,_s,_s,0,c_white,1)
    
    surface_reset_target()
  }
  
  Update = function(){
    x = lerp(x, dest.x,.1)
    y = lerp(y, dest.y,.1)
    
    var ms = GetMousePos()
    
    var _hover = point_in_rectangle(ms.x,ms.y,x-w*.5+marg,y-h*.5+marg,x+w*.5-marg,y+h*.5-marg)
    if _hover{
      if !hover{
        angle = 20
      }
      scale.x = lerp(scale.x,1.2,.05)
      scale.y = lerp(scale.y,1.2,.05)
    }else{
      scale.x = lerp(scale.x,1,.05)
      scale.y = lerp(scale.y,1,.05)
    }
    
    angle = lerp(angle,0,.2)
    
    hover = _hover
  }
  
  Draw = function() {
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
}