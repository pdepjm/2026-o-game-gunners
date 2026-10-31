import direcciones.*
import Inicioyfin.*

object colectivo {
    var property position = game.at(1, 1)
    var oldPosition = game.at(0, 1)
    var property vagones = []
    var direccion = derecha
    var property puntaje = 0
    var primerVagon = null

    method image() = "cabeza114_" + direccion.nombre() + ".png"
    
    method reiniciar() {
        position = administrador.nivel().posicionInicial()
        oldPosition = position.left(1)
        direccion = derecha
        vagones = []
        primerVagon = null
        puntaje = 0
    }

    method doblar(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method avanzar() {
        const posicionAnterior = position
        const direccionAnterior = direccion

        position = direccion.avanzar(position)

        if (primerVagon != null) {
        primerVagon.seguirA(posicionAnterior, direccionAnterior)
        }

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


    
    
    method agregarVagon () {
         var nuevoVagon = null
        
        if (vagones.isEmpty()) {
        const posAtras = self.posicionAtras(position, direccion)
        nuevoVagon = new Vagon(position = posAtras, direccion = direccion)
        primerVagon = nuevoVagon
        } else {
        const ultimoVagon = vagones.last()
        const posAtras = self.posicionAtras(ultimoVagon.position(), ultimoVagon.direccion())
        nuevoVagon = new Vagon(position = posAtras, direccion = ultimoVagon.direccion())
        ultimoVagon.siguiente(nuevoVagon)
        }

    vagones.add(nuevoVagon)
    game.addVisual(nuevoVagon)
    }



    method posicionAtras(pos, dire) {
     if (dire == arriba) {
      return pos.down(1)
    }
    
    if (dire == abajo) {
     return pos.up(1) 
    }

    if (dire == derecha) {
      return pos.left(1)
    }

      return pos.right(1)
    }

    method perderVagon() {
     if (!vagones.isEmpty()) {
     const vagonAEliminar = vagones.last()
     vagones.remove(vagonAEliminar)
     game.removeVisual(vagonAEliminar)

     if (vagones.isEmpty()) {
      primerVagon = null
    } else {
    vagones.last().siguiente(null)
    }
    puntaje = (puntaje - 10).max(0)
    }
    }

    method cambiarVelocidad(milisegundo) {
        game.removeTickEvent("movimientoColectivo")
        game.onTick(milisegundo, "movimientoColectivo", {self.avanzar()})
    }

    method relentizar() {
        self.cambiarVelocidad(600)
        game.schedule(5000, {self.cambiarVelocidad(300)})
    }
}

class Vagon {
    var property position
    var property direccion 
    var property siguiente = null
    
    method image() = "medio114_" + direccion.nombre() + ".png"
    method chocarCon(otro) {}

    method seguirA(nuevaPosicion, nuevaDireccion) {
    const posicionPrevia = position
    const direccionPrevia = direccion

    position = nuevaPosicion
    direccion = nuevaDireccion

    if (siguiente != null) {
    siguiente.seguirA(posicionPrevia, direccionPrevia)
    }
    }
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