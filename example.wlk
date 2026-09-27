object colectivo {
    var property position = game.at(1, 1)
    var property pasajeros = 0
    var direccion = "derecha"

    method image() = "114.png"
    
    method doblar(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method avanzar() {
        if(direccion == "derecha") {
            position = position.right(1)
        }
        if(direccion == "izquierda") {
            position = position.left(1)
        }
        if(direccion == "arriba") {
            position = position.up(1)
        }
        if(direccion == "abajo") {
            position = position.down(1)
        }
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
}

object senialDesvio {
    var property position = game.at(4, 4)
    
    method image() = "pozo.png"

    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }
}

object perdiste {
    var property position = game.center()
    method image() = "perdiste.png"
}