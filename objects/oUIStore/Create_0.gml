destroy = false
screen = GetScreenSize()
isMenuOpen = true
petSelected = noone

petsToBuy = []
cardsToBuy = []
cards = []

var _card = 200 * UI_SCALE
var _marg = 4*UI_SCALE

#region nav bar
navPage = 0
navItems = [
  "Pets",
  "Skins"
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
        AtualizaCardstoBuy()
        UpdateCardsPos(cardsToBuy)
        name.ResetAnimations()
        desc.ResetAnimations()
        price.ResetAnimations()
      
        global.cardSelected = noone
        break;
      case 1:
        AtualizaCards()
        UpdateCardsPos(cards)
      
        global.cardSelected = noone
        break;
    }
  }
  nav[i] = new CreateButtom( _boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,navItems[i],_func,[i])
}

#endregion

#region Pets
name = new CreateSurf(new Vector2(screen.w*.5 + _card*.5+_marg,screen.h*.5-_card*.5+40),new Vector2(300,80),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)  
  DrawTitleInSurf("Name",w)
  
  var _pet = GetPetSelectedToArray(other.petsToBuy)
  if _pet != noone{
    var _namePos = new Vector2(w*.5,h*.5)
    draw_text(_namePos.x,_namePos.y,_pet.name)
  }
  DrawReset()
},,1.5)

desc = new CreateSurf(new Vector2(screen.w*.5 + _card*.5+_marg,screen.h*.5-_card*.5+name.h+_marg+150),new Vector2(300,300),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Description",w)
  var _pet = GetPetSelectedToArray(other.petsToBuy)
  if _pet != noone{
    var _marg = 3*UI_SCALE
    var _descPos = new Vector2(_marg,40)
    DrawSetAling(0,0)
    draw_text(_descPos.x,_descPos.y,_pet.desc)
  }
  DrawReset()
},15,1.5)

price = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.5+60),new Vector2(300,120),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Price",w)
  
  var _pet = GetPetSelectedToArray(other.petsToBuy)
  if _pet != noone{
    DrawSetAling(1,1)
    var _textPos = new Vector2(w*.5,h*.5)
    draw_text(_textPos.x,_textPos.y,_pet.cost)
  }
},30,1.5)
#endregion


AtualizaPetsToBuy = function(){
  for(var i=0; i<PETS_DATABASE.Length();i++){
    var _pet = PETS_DATABASE.FindByIndice(i)
    var _canAdd = true
    for(var j=0; j<PLAYER_PETS_DATABASE.Length(); j++){
      var _playerPet = PLAYER_PETS_DATABASE.FindByIndice(j)
      if _playerPet.id == _pet.id{
        _canAdd = false
      }
    }
    if _canAdd {
      array_push(petsToBuy,_pet)
    }
  }
}

AtualizaPetsToBuy()

AtualizaCardstoBuy = function(){
  for( var i=0; i<array_length(petsToBuy); i++){
    var _timeDelay = i*10
    cardsToBuy[i] = new CreateCard( petsToBuy[i],_timeDelay)
  }
}

AtualizaCardstoBuy()

cards = []
AtualizaCards = function(){
  for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
    var _timeDelay = i*10
    cards[i] = new CreateCard( PLAYER_PETS_DATABASE.FindByIndice(i),_timeDelay)
  }
}

AtualizaCards()

offsetInd = 0
UpdateCardsPos(cardsToBuy)

AtualizaCardPos = function(){
  switch (navPage) {
  	case 0:
      UpdateCardsPos(cardsToBuy)
      var _len = array_length(cardsToBuy)
      for( var i=0; i<_len; i++){
        cardsToBuy[i].UpdateTargetsPos()
      }
      break
    case 1:
      UpdateCardsPos(cards)
      var _len = array_length(cards)
      for( var i=0; i<_len; i++){
        cards[i].UpdateTargetsPos()
      }
      break;
  }
  

}

ResetCurvePosCardSelected = function(){
  switch (navPage) {
  	case 0:
      var _len = array_length(cardsToBuy)
      for( var i=0; i<_len; i++){
        if cardsToBuy[i].pet.id == global.cardSelected{
          cardsToBuy[i].posCurve.reset()
        }
      }
      break;
    case 1:
      var _len = array_length(cards)
      for( var i=0; i<_len; i++){
        if cards[i].pet.id == global.cardSelected{
          cards[i].posCurve.reset()
        }
      }
      break;
  }
}

RedrawSurfaces = function(){
  switch (navPage) {
  	case 0:
      name.Redraw()
      desc.Redraw()
      price.Redraw()
      break;
    case 1:
      
      break;
  }
}