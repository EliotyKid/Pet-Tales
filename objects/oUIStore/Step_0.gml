if destroy instance_destroy()
  

switch (navPage) {
	case 0:
    for( var i=0; i<array_length(cardsToBuy); i++){
      cardsToBuy[i].Update()
    }
    name.Update()
    desc.Update()
    break;
  case 1:
    for( var i=0; i<array_length(cards); i++){
      cards[i].Update()
    }
    break;
}



for(var i=0; i<navLen; i++){
  nav[i].Step()
}
