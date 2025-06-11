function IndiceToVetor(_indice,_numCols){
  return new Vector2(_indice % _numCols,_indice div _numCols)
}

