function UpdateCardsPos(_cardsArray){
  var _total = array_length(_cardsArray)
  if _total == 0  return
    
  var _spacing = 360 / 20
  
  for(var i=0; i<_total; i++){
    var _initialAng = 90-(min(6,_total)  div 2) * _spacing
    var _dir = _initialAng + (i-offsetInd)*_spacing
    var _pos = new Vector2(room_width*.5-lengthdir_x(800,_dir),room_height+lengthdir_y(250,_dir))
    
    _cardsArray[i].generalPos = _pos
    
  }
}