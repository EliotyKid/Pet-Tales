global.PetDdata = {}
with (global.PetDdata) {
  __petsDataBase = []
  
  ///@arg {Struct} _pet
  Add = function(){
    array_push(__petsDataBase,argument0)
  }
  
  ///@arg {Real} _id
  ///@return {Struct,Undefined} 
  FindById = function(){
    for  (var i=0; i<array_length(__petsDataBase); i++){
      if  (__petsDataBase[i].id == argument0)  {
        return {
          pos: i,
          pet: variable_clone(__petsDataBase[i])
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
      return variable_clone(__petsDataBase[argument0])
    }
    
    return undefined
  }
  
  ///@return {Array} description
  List = function(){
    return variable_clone(__petsDataBase)
  }
  
  ///@return {real} 
  Length = function(){
    return array_length(__petsDataBase)
  }
}

#macro PETS_DATABASE global.PetDdata
