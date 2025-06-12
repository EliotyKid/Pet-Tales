function GetPetSelected(_base = PLAYER_PETS_DATABASE){
  var _pet = _base.FindById(global.cardSelected) ?? noone
  return _pet != noone ? _pet.pet : noone
}