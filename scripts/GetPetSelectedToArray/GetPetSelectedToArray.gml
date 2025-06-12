function GetPetSelectedToArray(_base){
  //show_debug_message(_base)
  for(var i=0; i<array_length(_base); i++){
    //show_message(_base[i])
    if _base[i].id == global.cardSelected return _base[i]
  }
  
  return noone
}