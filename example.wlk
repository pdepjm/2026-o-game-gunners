object colectivo {
    var property position = game.at(1, 1)
    
    method image() = "goat.png"
    
    method doblar(nuevaPosicion) {
        self.position(nuevaPosicion)
    }
}

object pasajero {
    var property position = game.center()
    
    method image() = "pasajero.png"
    
    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }
}