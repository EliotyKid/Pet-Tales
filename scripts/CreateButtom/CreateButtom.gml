function CreateButtom(_x,_y,_w,_h,_text = "",_scr = function(){},_args = []) constructor{
  x = _x
  y = _y
  w = _w
  h = _h 
  text = _text
  
  start = new Vector2(w,_y)
  delay = 0
  
  dest = new Vector2(_x, _y)
  
  needDisappear = true
  
  hover = false
  
  scr = _scr
  args = _args
  
  selected = false
  
  Step = function(){
    var isOpen = other.isMenuOpen
    var ms = GetMousePos()
    var _hover = point_in_rectangle(ms.x,ms.y,x-w*.5,y-h*.5,x+w*.5,y+h*.5)
    if _hover{
      if !hover{
        audio_play_sound(sndHoverBtn,1,false,6)
      }
      
      if mouse_check_button_pressed(mb_left){
        audio_play_sound(sndClickBtn,1,false)
        var _scr = scr
        var _args = args
        with (other) {
        	script_execute_ext(_scr,_args)
        }
      }
      //window_set_cursor(cr_handpoint)
    }
    
    x = lerp(x, isOpen ? dest.x : start.x ,.3-delay)
    
    hover = _hover

  }
  
  Draw = function(){
    var isOpen = other.isMenuOpen
    if point_distance(x,y,start.x,start.y)<2 && !isOpen && needDisappear exit
    
    DrawBox(hover || selected ? "lt" : "dt", x-w*.5,y-h*.5,w,h,UI_SCALE)
    DrawSetAling(1,1)
    draw_set_font(fTitle)
    draw_text(x,y,text)
    DrawReset()
  }
}