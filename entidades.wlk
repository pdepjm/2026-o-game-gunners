import direcciones.*
import Inicioyfin.*

object colectivo {
    var property position = game.at(1, 1)
    var oldPosition = game.at(0, 1)
    var property vagones = []
    var direccion = derecha
    var property puntaje = 0

    method image() = "cabeza114_" + direccion.nombre() + ".png"
    
    method reiniciar() {
        position = administrador.nivel().posicionInicial()
        oldPosition = position.left(1)
        direccion = derecha
        vagones = []
        puntaje = 0
    }

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

        if (self.chocoConsigoMismo()) {
        administrador.perder()
        } else if (administrador.nivel().esPared(position)) {
            self.chocarConPared()
        }

    }

    method chocarConPared() {
        game.removeTickEvent("movimientoColectivo")
        game.say(self, "¡Perdí! ¡Choqué contra la pared!")
        game.schedule(500, { administrador.perder() })
    }

    method chocarCon(otro) {
        otro.colisionarCon(self)
    }

    method chocoConsigoMismo() = vagones.any({ vagon => vagon.position() == position })

    method sumarPasajero() {
        puntaje += 10
        self.agregarVagon()
    }

    method agregarVagones(cantidad) {
        cantidad.times({ x => self.agregarVagon() })
    }

    method agregarVagon() {
        const nuevaDireccion = if (vagones.isEmpty()) direccion else vagones.last().direccion()
        const vagon = new Vagon(position = oldPosition, direccion = nuevaDireccion)
        vagones.add(vagon)
        game.addVisual(vagon)
    }
    
    method perderVagon() {
        const vagon = vagones.last()
        vagones.remove(vagon)
        game.removeVisual(vagon)
        puntaje = (puntaje - 10).max(0)
    }
}

class Vagon {
    var property position
    var property direccion 
    
    method image() = "medio114_" + direccion.nombre() + ".png"
    method chocarCon(otro) {}
}

object pasajero {
    var property position = game.center()
    
    method image() = "pasajero.png"
    
    method moverse() {
        position = administrador.nivel().posicionAleatoria()
    }

    method chocarCon(otro) {}

    method colisionarCon(objeto){
		objeto.sumarPasajero()
		self.moverse()
    }
}