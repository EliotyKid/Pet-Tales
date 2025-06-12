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
  DrawTitleInSurf("Name",w)
  
  var _pet = GetPetSelected()
  if _pet != noone{
    var _namePos = new Vector2(w*.5,h*.5)
    draw_text(_namePos.x,_namePos.y,_pet.name)
  }
  DrawReset()
},,2)

status = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.5+name.h+_marg+150), new Vector2(300,300),function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Status",w)
},15,2)

desc = new CreateSurf(new Vector2(screen.w*.5 + _card*.5+_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5), function(){
  DrawBox("dt",0,0,w,h,UI_SCALE)
  DrawTitleInSurf("Description",w)
  
  var _pet = GetPetSelected()
  if _pet != noone{
    var _marg = 3*UI_SCALE
    var _descPos = new Vector2(_marg,40)
    DrawSetAling(0,0)
    draw_text(_descPos.x,_descPos.y,_pet.desc)
  }
  DrawReset()
},30,2)
#endregion

#region Custom

custom = new CreateSurf(new Vector2(screen.w*.5-_card*.5-_marg,screen.h*.5-_card*.25),new Vector2(300,_card*.5),function(){
  var _pet = GetPetSelected()
  DrawBox("dt",0,0,w,h,UI_SCALE) 
  DrawTitleInSurf("Customize",w)
  
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
},,,true)

var _sliderW = 6*UI_SCALE
scroll = 0


skins = new CreateSurf(new Vector2(screen.w*.5+_card*.5+_marg+(_sliderW)*.5,screen.h*.5-_card*.25),new Vector2(300+_sliderW,_card*.5),function(){
  var _sliderW = 6*UI_SCALE
  var _marg = 4*UI_SCALE
  var _contentSize = new Vector2(w-_sliderW-_marg,h)
  DrawBox("dt",0,0,_contentSize.x,_contentSize.y,UI_SCALE)  
  
  var _pet = GetPetSelected()
  if _pet != noone{
    var _skins = array_filter(_pet.skins,function(element){
      return element.unlocked == true  
    })
    var _len = array_length(_skins)
    var _numCols = 2
    var _marg = 4*UI_SCALE
    var _boxSize = new Vector2((_contentSize.x-_marg*(2+_numCols-1))/_numCols,(_contentSize.x-_marg*(2+_numCols-1))/_numCols)
    for(var i=0; i<_len; i++){
      var _indicePos = IndiceToVetor(i,_numCols)
      var _boxPos = new Vector2(_marg+(_boxSize.x+_marg)*_indicePos.x,_marg*2+scroll+(_boxSize.y+_marg)*_indicePos.y)
      var _hover = point_in_rectangle(mousePos.x,mousePos.y,_boxPos.x,_boxPos.y,_boxPos.x+_boxSize.x,_boxPos.y+_boxSize.y)
      if _hover{
        if mouse_check_button_pressed(mb_left){
          _pet.skinSel = _pet.skinSel == _skins[i].id ? noone : _skins[i].id
          other.RedrawCardSelected()
          audio_play_sound(sndClickBtn,1,false)
        }
      }
      
      var isSelected = _pet.skinSel == _skins[i].id
      var isSelectedSpr = isSelected ? "green" : "lt"
      DrawBox(_hover ? "w" : isSelectedSpr ,_boxPos.x,_boxPos.y,_boxSize.x,_boxSize.y,UI_SCALE)
      
      var _sprPos = new Vector2(_boxPos.x+_boxSize.x*.5,_boxPos.y+_boxSize.y*.5)
      var _spr = asset_get_index(_skins[i].icon)
      var _scl = 4
      draw_sprite_ext(_spr,0,_sprPos.x,_sprPos.y,_scl,_scl,0,c_white,1)
    }
    
    var _a = _contentSize.y
    var _t = _marg*2.5+(_boxSize.y+_marg)*IndiceToVetor(_len-1,_numCols).y + _boxSize.y
    var _v = _t - _a
    var _diff = _v > 0 ? -_v : 0
    scroll = _diff * scrollSlide.GetScrollVal()
  }
  
  DrawBox("dt",0,h-_marg,w-_sliderW-_marg,_marg,UI_SCALE,false)
  DrawBox("dt",0,0,w-_sliderW-_marg,_marg*2.5,UI_SCALE,,,false)
  
  //DrawSliderVertical(new Vector2(_sliderW,h),new Vector2(w-_sliderW,0), "scroll")
  scrollSlide.Draw(mousePos)
  
  
  if point_in_rectangle(mousePos.x,mousePos.y,0,0,w,h){
    scrollSlide.slidePos.y += (mouse_wheel_down()-mouse_wheel_up())*20
    if scrollSlide.slidePos.y < 0 scrollSlide.slidePos.y = 0
    if scrollSlide.slidePos.y > scrollSlide.h-scrollSlide.slideSize.y scrollSlide.slidePos.y = scrollSlide.h-scrollSlide.slideSize.y
  }
  
  
  DrawTitleInSurf("Skins",_contentSize.x)
  DrawReset()
},15,,true,function(){
  var _sliderW = 6*UI_SCALE
  scrollSlide = new CreateSlide(new Vector2(w-_sliderW,0),new Vector2(_sliderW,h)) 
  
  scroll = 0   
})

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

