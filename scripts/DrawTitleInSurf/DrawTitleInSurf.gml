function DrawTitleInSurf(_title,_w){
  var _titlePos = new Vector2(_w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,_title) 
  DrawReset()
}