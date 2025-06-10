if destroy instance_destroy()
  
name.Update()
status.Update()
desc.Update()

for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i].Update()
}

offsetInd += (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))

if global.cardSelected != noone{
  var _pet = PLAYER_PETS_DATABASE.FindById(global.cardSelected)
  if _pet != undefined {
    petSelected = _pet.pet
    name.Redraw()
    desc.Redraw()
  }
  else petSelected = noone
}
