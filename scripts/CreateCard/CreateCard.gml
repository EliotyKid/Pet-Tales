function CreateCard(_pet,_delay = 0) constructor {
  var _screen = GetScreenSize()
  x = _screen.w*.5
  y = _screen.h*1.5
  
  start = new Vector2(x,y)
  
  dest = new Vector2(300,300)
  
  generalPos = new Vector2(300,300)
  
  pet = _pet
  
  w = 250
  h = 250
  marg = 25
  
  angle = 0
  scale = new Vector2(1,1)
  
  surf = surface_create(w,h)
  
  hover = false
  
  delay = _delay
  timerDelay = 0
  
  selectedPos = new Vector2(_screen.w*.5,_screen.h*.5-200)
  
  posCurve = new CurveRunner(acCard,"pos",2)
  angleCurve = new CurveRunner(acCard,"angle",.5)
  
  colorMode = ColorModFromSprite(pet.paletteSprite,0,true)
  
  SetDraw = function(){
    if surface_exists(surf){
      surface_set_target(surf)
      draw_clear_alpha(c_black,0)
      DrawBox(global.cardSelected == pet.id ? "w" : "w",marg,marg,w-marg*2,h-marg*2,UI_SCALE)
      
      var _centerPos = new Vector2(w*.5,h*.5)
      
      var _s = 7
      colorMode.SetShader(pet.paletteIndex)
      draw_sprite_ext(pet.sprite.idle,0,_centerPos.x,_centerPos.y,_s,_s,0,c_white,1)
      shader_reset()
      
      if pet.skinsLen > 0 && pet.skinSel != noone{
        var _skin = array_filter(pet.skins,function(element){
          return element.id == pet.skinSel  
        })
        
        draw_sprite_ext(asset_get_index(_skin[0].sprite),0,_centerPos.x,_centerPos.y,_s,_s,0,c_white,1)
      }
      
      
      surface_reset_target()
    }
  }
  SetDraw()
  
  UpdateTargetsPos = function(){
    dest = global.cardSelected == pet.id ? selectedPos : generalPos
    start = global.cardSelected == pet.id ? generalPos : selectedPos
  }
  UpdateTargetsPos()
  
  Update = function(){
    if timerDelay < delay{
      timerDelay ++
      exit
    }

    var ms = GetMousePos()
    
    var _hover = point_in_rectangle(ms.x,ms.y,x-w*.5+marg,y-h*.5+marg,x+w*.5-marg,y+h*.5-marg)
    if _hover && global.cardSelected != pet.id{
      if global.cardHovered == noone{
        global.cardHovered = pet.id
      }
      
      if !hover{
        angleCurve.reset()
        audio_play_sound(sndHoverBtn,1,false,6)
        scale.x = 1.4
      }
      scale.x = lerp(scale.x,1.2,.1)
      scale.y = lerp(scale.y,1.2,.1)
      
      if mouse_check_button_pressed(mb_left) && global.cardHovered == pet.id{
        //TODO logica de armazenar os pet atual pra pegar ae modificar as infos
        scale.x += .2
        scale.y -= .1
        //show_debug_message(pet.desc)
        
        if instance_exists(oUIMyPets){
          oUIMyPets.AtualizaCardPos()
          oUIMyPets.ResetCurvePosCardSelected()
        }
        
        if instance_exists(oUIStore){
          oUIStore.AtualizaCardPos()
          oUIStore.ResetCurvePosCardSelected()
          oUIStore.RedrawSurfaces()
        }
        global.cardSelected = pet.id
        
        if instance_exists(oUIStore){
          oUIStore.RedrawSurfaces()
        }
        
        if instance_exists(oUIMyPets){
          oUIMyPets.RedrawSurfaces()
        }
        
        posCurve.reset()
        audio_play_sound(sndClickBtn,1,false)
      }
    }else{
      scale.x = lerp(scale.x,1,.05)
      scale.y = lerp(scale.y,1,.05)
      
      if global.cardHovered == pet.id global.cardHovered = noone
    }
    
    if global.cardSelected == pet.id{
      scale.x = lerp(scale.x,UI_SCALE*.5,.2)
      scale.y = lerp(scale.y,UI_SCALE*.5,.2)
      
    }
    UpdateTargetsPos()
    var _pos = posCurve.getPos()
    if _pos < 1{
      var _val = posCurve.getValue()
      x = start.x + (_val * (dest.x - start.x))
      y = start.y + (_val * (dest.y - start.y))
    }
    
    
    var _val = angleCurve.getValue()
    angle = 20*_val
    
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