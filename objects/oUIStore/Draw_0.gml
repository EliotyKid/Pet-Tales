draw_text(room_width*.5,room_height*.5,"Loja")

switch (navPage) {
	case 0:
    for( var i=0; i<array_length(cardsToBuy); i++){
      cardsToBuy[i].Draw()
    }
    name.Draw()
    desc.Draw()
    break;
  case 1:
    for( var i=0; i<array_length(cards); i++){
      cards[i].Draw()
    }
    break;
}


for(var i=0; i<navLen; i++){
  nav[i].Draw()
  nav[i].selected = i == navPage
}