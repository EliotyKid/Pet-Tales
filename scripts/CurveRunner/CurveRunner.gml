
/// @function CurveRunner(curve, duration)
/// @desc Retorna uma struct com .get_value() que avança no tempo baseado em delta_time
function CurveRunner(_curve, _chanel, _duration) constructor  {
  curve = animcurve_get_channel(_curve,_chanel)
  duration = _duration
  pos = 0

  // Retorna o valor atual da curva e avança o tempo
  getValue = function()  {
    var _dt = delta_time / 1000000 // converte pra segundos
    var _speed = 1 / max(duration, 0.001) // garante que não divide por 0

    pos += _dt * _speed
    pos = clamp(pos, 0, 1)

    return animcurve_channel_evaluate(curve, pos)
  }
  
  getPos = function(){
    return pos
  }

  // Reinicia a curva se quiser reutilizar
  reset = function()  {
    pos = 0
  }
  
  destroy = function(){
    animcurve_destroy(curve)
  }
}
