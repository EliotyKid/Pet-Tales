menuItems = [
  "Meus Pets",
  "Loja",
  "Configurações",
  "Sair"
]

menuLen = array_length(menuItems)

menuPos = new Vector2(10,room_width*.4)

scl = UI_SCALE

openBtnPos = new Vector2(menuPos.x+200,menuPos.y)
openBtnSize = new Vector2(50,100)

isMenuOpen = false

menuPage = noone



openBtn = new CreateButtom(menuPos.x+300,menuPos.y,50,100,,function(){
  isMenuOpen = !isMenuOpen  
  
  if !isMenuOpen{
    if instance_exists(oUIMyPets) oUIMyPets.destroy = true
    if instance_exists(oUIStore) oUIStore.destroy = true
    if instance_exists(oUISettings) oUISettings.destroy = true
    if instance_exists(oUIExit) oUIExit.destroy = true
      
    global.cardSelected = noone
    menuPage = noone
  }
})
openBtn.needDisappear = false


menuBtns = []
for( var i=0; i<menuLen; i++){
  var _marg = 4*scl
  var _boxSize = new Vector2(200,60)
  var _diff = ((_boxSize.y+_marg)*(menuLen-1))*.5
  var _boxPos = new Vector2(menuPos.x+_boxSize.x*.5,menuPos.y+(_boxSize.y+_marg)*i-_diff)
  menuBtns[i] = new CreateButtom(_boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,menuItems[i])
  menuBtns[i].start.x = -_boxSize.x*2
  menuBtns[i].delay = (1+i)*(.2/menuLen)
}

menuBtns[0].scr = function(){
  if !instance_exists(oUIMyPets) {
    instance_create_layer(0,0,"UI",oUIMyPets)
    menuPage = 0
  }
  else {
    oUIMyPets.destroy = true
    menuPage = noone
  }
    
  if instance_exists(oUIStore) oUIStore.destroy = true
  if instance_exists(oUISettings) oUISettings.destroy = true
  if instance_exists(oUIExit) oUIExit.destroy = true
    
  //isMenuOpen = false
  global.cardSelected = noone
}

menuBtns[1].scr = function(){
  if !instance_exists(oUIStore) {
    instance_create_layer(0,0,"UI",oUIStore)
    menuPage = 1
  }
  else {
    oUIStore.destroy = true
    menuPage = noone
  }
  
  if instance_exists(oUIMyPets) oUIMyPets.destroy = true
  if instance_exists(oUISettings) oUISettings.destroy = true
  if instance_exists(oUIExit) oUIExit.destroy = true
    
  //isMenuOpen = false
  global.cardSelected = noone
}

menuBtns[2].scr = function(){
  if !instance_exists(oUISettings) {
    instance_create_layer(0,0,"UI",oUISettings)
    menuPage = 2
  }
  else {
    oUISettings.destroy = true
    menuPage = noone
  }
    
  if instance_exists(oUIMyPets) oUIMyPets.destroy = true
  if instance_exists(oUIStore) oUIStore.destroy = true
  if instance_exists(oUIExit) oUIExit.destroy = true
    
  //isMenuOpen = false
  global.cardSelected = noone
}

menuBtns[3].scr = function(){
  if !instance_exists(oUIExit) {
    instance_create_layer(0,0,"UI",oUIExit)
    menuPage = 3
  }
  else {
    oUIExit.destroy = true
    menuPage = noone
  }
  
  if instance_exists(oUIMyPets) oUIMyPets.destroy = true
  if instance_exists(oUIStore) oUIStore.destroy = true
  if instance_exists(oUISettings) oUISettings.destroy = true
    
  //isMenuOpen = false
  global.cardSelected = noone
}