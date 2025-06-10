destroy = false
screen = GetScreenSize()


var _card = 200 * UI_SCALE
var _marg = 4*UI_SCALE

name = new CreateSurf(new Vector2(screen.w*.5 - _card*.5-_marg,screen.h*.5-_card*.5+40),new Vector2(300,80),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  var _titlePos = new Vector2(w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,"Name")
  DrawReset()
})

status = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.5+name.h+_marg+150), new Vector2(300,300),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  var _titlePos = new Vector2(w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,"Status")
  DrawReset()
},15)

desc = new CreateSurf(new Vector2(screen.w*.5 + _card*.5+_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5), function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  var _titlePos = new Vector2(w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,"Description")
  DrawReset()
},30)

playerPets = PLAYER_PETS_DATABASE.List()

cards = []
for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  cards[i] = new CreateCard( PLAYER_PETS_DATABASE.FindByIndice(i))
}

offsetInd = 0

UpdateCardsPos(cards)