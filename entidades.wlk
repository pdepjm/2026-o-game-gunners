import direcciones.*
import Inicioyfin.*

object colectivo {
    var property position = game.at(1, 1)
    var property vagones = []
    var property direccion = derecha
    var property puntaje = 0
    var property vidas = 0
    var property velocidad = 300
    var primerVagon = null

    method image() = "cabeza114_" + direccion.nombre() + ".png"

    method reiniciar() {
        position = administrador.nivel().posicionInicial()
        direccion = derecha
        vagones = []
        primerVagon = null
        puntaje = 0
        vidas = 0
        velocidad = 300
    }

    method tieneVidas() = vidas > 0

    method sumarVida() {
        vidas += 1
    }

    method gastarVida() {
        vidas = (vidas - 1).max(0)
        position = administrador.nivel().posicionInicial()
        direccion = derecha
        vagones.forEach({ vagon =>
            vagon.position(position)
            vagon.direccion(direccion)
            vagon.direccionAnterior(null)
        })
    }

    method doblar(nuevaDireccion) {
        if (direccion.opuesta() != nuevaDireccion && direccion != nuevaDireccion) {
            direccion = nuevaDireccion
        }
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
            position = posicionAnterior 
            self.chocarConPared()
        }
    }

    method chocarConPared() {
        game.removeTickEvent("movimientoColectivo")
        game.say(self, "¡Perdí! ¡Choqué contra la pared!")
        game.schedule(500, { administrador.perder() })
    }

    method chocarCon(otro) {
        otro.colisionarConColectivo()
    }

    method chocoConsigoMismo() = vagones.any({ vagon => vagon.position() == position })

    method sumarPasajeros(cantidad) {
        puntaje += 10 * cantidad
        self.agregarVagones(cantidad)
    }

    method agregarVagones(cantidad) {
        cantidad.times({ x => self.agregarVagon() })
    }

    method agregarVagon() {
        var nuevoVagon = null

        if (vagones.isEmpty()) {
            const posAtras = self.posicionAtras(position, direccion)
            nuevoVagon = new Vagon(position = posAtras, direccion = direccion)
            primerVagon = nuevoVagon
        } else {
            const ultimoVagon = vagones.last()
            const direccionCola = if (ultimoVagon.direccionAnterior() == null) ultimoVagon.direccion() else ultimoVagon.direccionAnterior()
            const posAtras = self.posicionAtras(ultimoVagon.position(), direccionCola)
            nuevoVagon = new Vagon(position = posAtras, direccion = direccionCola)
            ultimoVagon.siguiente(nuevoVagon)
        }

        vagones.add(nuevoVagon)
        game.addVisual(nuevoVagon)
    }

    method posicionAtras(pos, dire) = dire.opuesta().avanzar(pos)

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
        } else {
            administrador.perder()
        }
    }

    method cambiarVelocidad(nuevaVelocidad) {
        velocidad = nuevaVelocidad
        game.removeTickEvent("movimientoColectivo")
        game.onTick(nuevaVelocidad, "movimientoColectivo", { self.avanzar() })
    }

    method ralentizar() {
        self.cambiarVelocidad(600)
        game.schedule(5000, { self.cambiarVelocidad(300) })
    }
}

class Vagon {
    var property position
    var property direccion
    var property siguiente = null
    var property direccionAnterior = null

    method prefijoImagen() {
        if (direccionAnterior != null && direccionAnterior != direccion) {
            return "curva114_" + direccionAnterior.nombre() + "_"
        } else {
            return "medio114_"
        }
    }

    method image() = self.prefijoImagen() + direccion.nombre() + ".png"
    method chocarCon(otro) {}

    method seguirA(nuevaPosicion, nuevaDireccion) {
        const posicionPrevia = position
        const direccionPrevia = direccion

        position = nuevaPosicion
        direccion = nuevaDireccion
        direccionAnterior = direccionPrevia

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

    method colisionarConColectivo() {
        colectivo.sumarPasajeros(1)
        self.moverse()
    }
}

object pasajeroVip {
    var property position = game.at(2, 11)

    method image() = "pasajero_vip.png"

    method moverse() {
        position = administrador.nivel().posicionAleatoria()
    }

    method chocarCon(otro) {}

    method colisionarConColectivo() {
        colectivo.sumarPasajeros(3)
        self.moverse()
    }
}