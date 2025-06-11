function DrawTitleInSurf(_title){
  var _titlePos = new Vector2(w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,_title) 
  DrawReset()
}