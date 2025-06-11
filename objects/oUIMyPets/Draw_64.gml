draw_text(screen.w*.5,screen.h*.5,"Meus Pets")

switch (navPage) {
	case 0: 
    name.Draw()
    status.Draw()
    desc.Draw()
    break;
}
for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i].Draw()
}

for(var i=0; i<navLen; i++){
  nav[i].Draw()
}