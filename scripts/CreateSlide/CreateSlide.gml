function CreateSlide(_pos,_size) constructor{
  x = _pos.x
  y = _pos.y
  w = _size.x
  h = _size.y
  
  selected = false
  
  slidePos = new Vector2(x,y)
  slideSize = new Vector2(w,w*3)
  
  GetScrollVal = function(){
    return (slidePos.y - y) / (h-slideSize.y)
  }
  
  Draw = function(_mousePos){
    
    DrawBox("dt",x,y,w,h,UI_SCALE)
    
    var _hover = point_in_rectangle(_mousePos.x,_mousePos.y,slidePos.x,slidePos.y,slidePos.x+slideSize.x,slidePos.y+slideSize.y)
    if _hover && mouse_check_button_pressed(mb_left) selected = true
    if mouse_check_button_released(mb_left) selected = false
    
    if selected{
      slidePos.y = _mousePos.y-slideSize.y*.5
    }
    slidePos.y = clamp(slidePos.y,y,y+h-slideSize.y)
    
    DrawBox(_hover || selected ? "w" : "lt",slidePos.x,slidePos.y,slideSize.x,slideSize.y,UI_SCALE)
  }
}