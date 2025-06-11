function DrawIncrementDecrement(_text,_size,_pos,_func1 = function(){},_func2 = function(){}){
  DrawSetAling(1,1)
  draw_text(_pos.x+_size.x*.5,_pos.y+_size.y*.5,_text)
  
  var _squadSize = new Vector2(_size.y*.8,_size.y*.8)
  var _squadPos = new Vector2(_pos.x+(_size.y-_squadSize.y),_pos.y+_size.y*.5-_squadSize.y*.5)
  draw_rectangle(_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y,false)
  var _hover = point_in_rectangle(mousePos.x,mousePos.y,_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y)
  if _hover{
    if mouse_check_button_pressed(mb_left){
      script_execute(_func1)
      audio_play_sound(sndClickBtn,1,false)
    }
  }
  
  var _squadPos = new Vector2(_pos.x+_size.x-_squadSize.x-(_size.y-_squadSize.y),_pos.y+_size.y*.5-_squadSize.y*.5)
  draw_rectangle(_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y,false)
  var _hover = point_in_rectangle(mousePos.x,mousePos.y,_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y)
  if _hover{
    if mouse_check_button_pressed(mb_left){
      script_execute(_func2)
      audio_play_sound(sndClickBtn,1,false)
    }
  }
}