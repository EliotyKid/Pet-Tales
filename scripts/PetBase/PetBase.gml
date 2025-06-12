/// @arg {Real} _type
/// @arg {String} _sprite
/// @arg {String} _desc
/// @arg {Real} _cost
/// @arg {Asset.GMScript} _behavior
function PetBase(_type,_sprite,_desc,_cost = 10,_behavior = PBFollowMouse) constructor {
  name = undefined
  id = GetNextId()
  sprite = {}
  with sprite {
    idle = asset_get_index("s"+_sprite + "Idle")
    walk = asset_get_index("s"+_sprite + "Walk")
  }
  desc = _desc
  type = _type
  cost = _cost
  
  isActive = false
  behavior = _behavior
  
  status = []
  status[PET_STATUS.HAPPINESS] = ["Happines", .3]
  status[PET_STATUS.HUNGER] = ["Hunger", 0]
  status[PET_STATUS.SLEEP] = ["Sleep", 0]
  
  paletteSprite = asset_get_index("s"+_sprite+"Palette")
  paletteIndex = 0
  paletteLenght = sprite_get_height(paletteSprite)
  
  skins = GetSkins(_sprite)
  skinsLen = array_length(skins)
  skinSel = noone
  
  function NextPalette(){
    if paletteIndex < paletteLenght-1{
      paletteIndex++
    }else{
      paletteIndex = 0
    }
  }
  
  function BeforePalette(){
    if paletteIndex > 0 {
      paletteIndex--
    }else{
      paletteIndex = paletteLenght-1
    }
  }
}

enum PET_STATUS {
  HAPPINESS,
  HUNGER,
  SLEEP,
  LENGHT
}

