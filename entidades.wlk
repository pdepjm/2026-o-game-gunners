import direcciones.*

object colectivo {
    var property position = game.at(1, 1)
    var oldPosition = game.at(0, 1)
    var property vagones = []
    var direccion = derecha
    var property puntaje = 0

    method image() = "cabeza114_" + direccion.nombre() + ".png"
    
    method doblar(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method avanzar() {
        var posicionAnterior = position
        var direccionAnterior = direccion
        position = direccion.avanzar(position)
        vagones.forEach({ vagon =>
            const posicionActual = vagon.position()
            const direccionActual = vagon.direccion()
            vagon.position(posicionAnterior)
            vagon.direccion(direccionAnterior)
            posicionAnterior = posicionActual
            direccionAnterior = direccionActual
        })
        oldPosition = posicionAnterior
    }

    method sumarPasajero() {
        puntaje += 10
        const nuevaDireccion = if (vagones.isEmpty()) direccion else vagones.last().direccion()
        const vagon = new Vagon(position = oldPosition, direccion = nuevaDireccion)
        vagones.add(vagon)
        game.addVisual(vagon)
    }
}

class Vagon {
    var property position
    var property direccion 
    
    method image() = "medio114_" + direccion.nombre() + ".png"
}

object pasajero {
    var property position = game.center()
    
    method image() = "pasajero.png"
    
    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }

    method colisionarCon(objeto){
		objeto.sumarPasajero()
		self.moverse()
    }
}