var sc
destroy = false
screen = GetScreenSize()
isMenuOpen = true
petSelected = noone

var _card = 200 * UI_SCALE
var _marg = 4*UI_SCALE

navPage = 0
navItems = [
  "About",
  "Custom"
]
navLen = array_length(navItems)
nav = []
for(var i=0; i<navLen; i++){
  var _boxSize = new Vector2(150,50)
  var _diff = (_boxSize.x+_marg)*(navLen-1)*.5
  var _boxPos = new Vector2(screen.w*.5+(_marg+_boxSize.x)*i-_diff,100)
  var _func = function(_ind){
    navPage = _ind
    switch (navPage) {
    	case 0:
        name.ResetAnimations()
        status.ResetAnimations()
        desc.ResetAnimations()
        
        break;
    }
  }
  nav[i] = new CreateButtom( _boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,navItems[i],_func,[i])
}



name = new CreateSurf(new Vector2(screen.w*.5 - _card*.5-_marg,screen.h*.5-_card*.5+40),new Vector2(300,80),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  var _titlePos = new Vector2(w*.5,15)
  DrawSetAling(1,1)
  draw_text(_titlePos.x,_titlePos.y,"Name")
  
  if other.petSelected != noone{
    var _namePos = new Vector2(w*.5,h*.5)
    draw_text(_namePos.x,_namePos.y,other.petSelected.name)
  }
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
  
   if other.petSelected != noone{
    var _marg = 3*UI_SCALE
    var _descPos = new Vector2(_marg,40)
    DrawSetAling(0,0)
    draw_text(_descPos.x,_descPos.y,other.petSelected.desc)
  }
  DrawReset()
},30)

#region Crds
cards = []
for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
  var _timeDelay = i*10
  cards[i] = new CreateCard( PLAYER_PETS_DATABASE.FindByIndice(i),_timeDelay)
}

offsetInd = 0

UpdateCardsPos(cards)

AtualizaCardPos = function(){
  UpdateCardsPos(cards)
  var _len = array_length(cards)
  for( var i=0; i<_len; i++){
    cards[i].UpdateTargetsPos()
  }

}

ResetCurvePosCardSelected = function(){
  var _len = array_length(cards)
  for( var i=0; i<_len; i++){
    if cards[i].pet.id == global.cardSelected{
      cards[i].posCurve.reset()
    }
  }
}

#endregion