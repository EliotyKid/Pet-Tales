openBtn.Step()

for( var i=0; i<menuLen; i++){
  menuBtns[i].Step()
  menuBtns[i].selected = i == menuPage
}