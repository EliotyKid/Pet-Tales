if IsGame(){
  if !instance_exists(oUiControll) instance_create_layer(0,0,"UI",oUiControll)
  else instance_destroy(oUiControll)
}