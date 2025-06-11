function GetPetSelected(){
  var _pet = PLAYER_PETS_DATABASE.FindById(global.cardSelected) ?? noone
  return _pet != noone ? _pet.pet : noone
}