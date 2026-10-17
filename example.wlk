object colectivo {
    var property position = game.at(1, 1)
    var property pasajeros = 0
    var direccion = derecha

    method image() = "114.png"
    
    method doblar(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method avanzar() {
        position = direccion.avanzar(position)
    }

    method sumarPasajero() {
        pasajeros += 1
    }
}

object pasajero {
    var property position = game.center()
    
    method image() = "pasajero1.png"
    
    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }

    method colisionarCon(objeto){
		objeto.sumarPasajero()
		game.say(objeto, ("Tengo " + objeto.pasajeros()) + " pasajeros")
		self.moverse()
    }
}

class Obstaculo {
    var property position
    var property image 

    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }

    method colisionarCon(objeto){
		game.removeTickEvent("movimientoColectivo")
		game.say(objeto, "¡Perdí! ¡Choqué con algo!")
		game.schedule(500, { game.stop() })
    }
}

const pozo = new Obstaculo(position = game.at(4, 4), image = "pozo.png")

object perdiste {
    var property position = game.center()
    method image() = "perdiste.png"
}

object arriba {
    method avanzar(posicion) {
        return posicion.up(1)
    }
}

object abajo {
    method avanzar(posicion) {
        return posicion.down(1)
    }
}
object izquierda {
    method avanzar(posicion) {
        return posicion.left(1)
    }
}

object derecha {
    method avanzar(posicion) {
        return posicion.right(1)
    }
}