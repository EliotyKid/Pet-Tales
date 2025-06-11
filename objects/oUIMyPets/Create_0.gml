var sc
destroy = false
screen = GetScreenSize()
isMenuOpen = true
petSelected = noone

var _card = 200 * UI_SCALE
var _marg = 4*UI_SCALE

#region nav bar
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
      case 1:
        custom.ResetAnimations()
        skins.ResetAnimations()
        break;
    }
  }
  nav[i] = new CreateButtom( _boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,navItems[i],_func,[i])
}

#endregion

#region About
name = new CreateSurf(new Vector2(screen.w*.5 - _card*.5-_marg,screen.h*.5-_card*.5+40),new Vector2(300,80),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Name")
  
  var _pet = GetPetSelected()
  if _pet != noone{
    var _namePos = new Vector2(w*.5,h*.5)
    draw_text(_namePos.x,_namePos.y,_pet.name)
  }
  DrawReset()
})

status = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.5+name.h+_marg+150), new Vector2(300,300),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Status")
},15)

desc = new CreateSurf(new Vector2(screen.w*.5 + _card*.5+_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5), function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Description")
  
  var _pet = GetPetSelected()
  if _pet != noone{
    var _marg = 3*UI_SCALE
    var _descPos = new Vector2(_marg,40)
    DrawSetAling(0,0)
    draw_text(_descPos.x,_descPos.y,_pet.desc)
  }
  DrawReset()
},30)
#endregion

#region Custom

custom = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5),function(){
  var _pet = GetPetSelected()
  DrawBox("dt",0,0,w,h,UI_SCALE) 
  DrawTitleInSurf("Customize")
  
  var _marg = 4*UI_SCALE
  DrawTogle("Follow",new Vector2(w-_marg*2,30),new Vector2(_marg,30),_pet != noone ? _pet.isActive : false,function(){
    var _pet = GetPetSelected()
    if _pet != noone _pet.isActive = !_pet.isActive 
  })
  
  DrawIncrementDecrement("Color",new Vector2(w-_marg*2,30),new Vector2(_marg,80),function(){
    var _pet = GetPetSelected()
    if _pet != noone{
      _pet.BeforePalette()
      other.RedrawCardSelected()
    }
  },function(){
    var _pet = GetPetSelected()
    if _pet != noone{
      _pet.NextPalette()
      other.RedrawCardSelected()
    }
  })
  
  
  DrawReset()
},,true)

skins = new CreateSurf(new Vector2(screen.w*.5+_card*.5+_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)  
  var _marg = 4*UI_SCALE
  DrawTitleInSurf("Skins")
},15)

#endregion

#region Cards
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

RedrawCardSelected = function(){
  for( var i=0; i<PLAYER_PETS_DATABASE.Length(); i++){
    if cards[i].pet.id == global.cardSelected{
      cards[i].SetDraw()
    }
  }
}
#endregion

function DrawIncrementDecrement(_text,_size,_pos,_func1 = function(){},_func2 = function(){}){
  DrawSetAling(1,1)
  draw_text(_pos.x+_size.x*.5,_pos.y+_size.y*.5,_text)
  
  var _squadSize = new Vector2(_size.y*.8,_size.y*.8)
  var _squadPos = new Vector2(_pos.x+(_size.y-_squadSize.y),_pos.y+_size.y*.5-_squadSize.y*.5)
  draw_rectangle(_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y,false)
  var _hover = point_in_rectangle(mousePos.x,mousePos.y,_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y)
  if _hover{
    if mouse_check_button_pressed(mb_left){
      script_execute(_func1)
    }
  }
  
  var _squadPos = new Vector2(_pos.x+_size.x-_squadSize.x-(_size.y-_squadSize.y),_pos.y+_size.y*.5-_squadSize.y*.5)
  draw_rectangle(_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y,false)
  var _hover = point_in_rectangle(mousePos.x,mousePos.y,_squadPos.x,_squadPos.y,_squadPos.x+_squadSize.x,_squadPos.y+_squadSize.y)
  if _hover{
    if mouse_check_button_pressed(mb_left){
      script_execute(_func2)
    }
  }
}