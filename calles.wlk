class SeguimientoCalle {
  var property position

  method chocarCon(otro) {}

  method posicionContraria(posicion) {
    if (posicion.x() == -1) {
      return game.at(game.width() - 1, posicion.y())
    }
    if (posicion.x() == game.width()) {
      return game.at(0, posicion.y())
    }
    if (posicion.y() == -1) {
      return game.at(posicion.x(), game.height() - 1)
    }
    return game.at(posicion.x(), 0)
  }
}

object generadorCalles {

	method calleSalida(posicion) {
	  const calle = new SeguimientoCalle(position = posicion)
	  game.addVisual(calle)
	
	  game.onCollideDo(calle, { col =>
	    col.position(calle.posicionContraria(col.position()))
	  })	
	}

  method generar() {
    (0 .. game.width() - 1).forEach({ i =>
      self.calleSalida(game.at(i, -1))
      self.calleSalida(game.at(i, game.height()))
    })

    (0 .. game.height() - 1).forEach({ i =>
      self.calleSalida(game.at(-1, i))
      self.calleSalida(game.at(game.width(), i))
    })
  }
}
