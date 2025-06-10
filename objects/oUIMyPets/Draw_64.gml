draw_text(screen.w*.5,screen.h*.5,"Meus Pets")

name.Draw()
status.Draw()
desc.Draw()

for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i].Draw()
}