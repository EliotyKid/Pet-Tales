if destroy instance_destroy()

switch (navPage) {
	case 0:
    name.Update()
    status.Update()
    desc.Update()
    break;
  case 1:
    custom.Update()
    skins.Update()
    break;
}
name.Update()
status.Update()
desc.Update()

for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i].Update()
}

var _oldOffsetInd = offsetInd
offsetInd += (keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))
if offsetInd != _oldOffsetInd {
  AtualizaCardPos()
  ResetCurvePosCardSelected()
}

//if global.cardSelected != noone{
  //var _pet = GetPetSelected()
  //if _pet != noone {
    //name.Redraw()
    //desc.Redraw()
  //}
//}

for(var i=0; i<navLen; i++){
  nav[i].Step()
}
