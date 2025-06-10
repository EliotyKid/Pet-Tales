#region initialize DB
global.PlayerPetsData = {}
with (global.PlayerPetsData) {
  __playerDataBase = []
  
  ///@arg {Struct} _pet
  Add = function(){
    array_push(__playerDataBase,argument0)
  }
  
  ///@arg {Real} _id
  ///@return {Struct,Undefined} 
  FindById = function(){
    for  (var i=0; i<array_length(__playerDataBase); i++){
      if  (__playerDataBase[i].id == argument0)  {
        return {
          pos: i,
          pet: __playerDataBase[i]
        }
      }
    }
    
    show_debug_message($"Pet com o ID {argument0} não encontrado")
    return undefined
  }
  
  ///@arg {Real} _indice
  ///@return {Struct,Undefined} 
  FindByIndice = function(){
    if argument0 < Length() && argument0 >= 0{
      return __playerDataBase[argument0]
    }
    
    return undefined
  }
  
  ///@return {Array} 
  List = function(){
    return __playerDataBase
  }
  
  ///@return {real} 
  Length = function(){
    return array_length(__playerDataBase)
  }
}

#macro PLAYER_PETS_DATABASE global.PlayerPetsData
#endregion

PLAYER_PETS_DATABASE.Add(PETS_DATABASE.FindById(0).pet)
//PLAYER_PETS_DATABASE.Add(PETS_DATABASE.FindById(1).pet)
//
//PLAYER_PETS_DATABASE.Add(PETS_DATABASE.FindById(2).pet)
//
//PLAYER_PETS_DATABASE.Add(PETS_DATABASE.FindById(4).pet)
//PLAYER_PETS_DATABASE.Add(PETS_DATABASE.FindById(5).pet)


