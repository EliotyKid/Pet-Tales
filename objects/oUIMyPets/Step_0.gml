if destroy instance_destroy()
  
name.Update()
status.Update()
desc.Update()

for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i].Update()
}



offsetInd += (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))