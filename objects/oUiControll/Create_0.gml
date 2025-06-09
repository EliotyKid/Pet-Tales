menuItems = [
  "Meus Pets",
  "Loja",
  "Configurações",
  "Sair"
]

menuLen = array_length(menuItems)

menuPos = new Vector2(10,room_width*.4)

scl = 4

openBtnPos = new Vector2(menuPos.x+200,menuPos.y)
openBtnSize = new Vector2(50,100)

isMenuOpen = false



openBtn = new CreateButtom(menuPos.x+300,menuPos.y,50,100,,function(){
  isMenuOpen = !isMenuOpen  
})
openBtn.needDisappear = false
invertIsOpen = function(){
  isMenuOpen = !isMenuOpen
}

menuBtns = []
for( var i=0; i<menuLen; i++){
  var _marg = 4*scl
  var _boxSize = new Vector2(200,60)
  var _diff = ((_boxSize.y)*menuLen-2)*.5
  var _boxPos = new Vector2(menuPos.x+_boxSize.x*.5,menuPos.y+(_boxSize.y+_marg)*i-_diff)
  menuBtns[i] = new CreateButtom(_boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,menuItems[i])
  menuBtns[i].start.x = -_boxSize.x*2
  menuBtns[i].delay = (1+i)*(.2/menuLen)
}