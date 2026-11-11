import entidades.*
import Inicioyfin.*

class Obstaculo {
    var property position

    method image()
    method mensajeColision()
    method intervalo() = 9000

    method moverse() {
        position = administrador.nivel().posicionAleatoria()
    }

    method aparecer() {
        game.addVisual(self)
        game.onTick(self.intervalo(), "movimiento" + self.identity(), { self.moverse() })
        game.onCollideDo(self, { objeto => objeto.chocarCon(self) })
    }
    
    method chocarCon(otro) {}

    method colisionarConColectivo(){
		game.say(colectivo, self.mensajeColision())
		administrador.perder()
    }

    method tiempoDeEspera(){
        game.removeVisual(self)
        game.schedule(self.intervalo(), { game.addVisual(self) })
    }
}

class Pozo inherits Obstaculo {
    override method image() = "pozo2.png"
    override method mensajeColision() = "¡Perdí! ¡Me caí en un pozo!"
}

class Cabra inherits Obstaculo {
    override method image() = "cabra.png"
    override method intervalo() = 3000
    override method mensajeColision() = "¡Perdí! ¡Me comí una cabra!"

    override method colisionarConColectivo() {
        colectivo.perderVagon()
        self.tiempoDeEspera()
    }
}

class Vip inherits Obstaculo {
    override method image() = "pasajero_vip.png"
    override method intervalo() = 5000
    override method mensajeColision() = "¡Ahora tengo tres colas más!"

    override method colisionarConColectivo() {
        game.say(colectivo, self.mensajeColision())
        colectivo.agregarVagones(3)
        colectivo.puntaje(colectivo.puntaje() + 30)
        self.moverse()
    }
}

class VallaBloqueo inherits Obstaculo {
    override method image() = "valla.png"
    override method mensajeColision() = "¡Choqué contra la zona clausurada!"
    override method moverse() {}
}

class ClausuraDeCalle inherits Obstaculo {
    const alturaBloqueo = 7

    override method image() = "cono.png"
    override method mensajeColision() = "¡Calle clausurada por obras!"

    override method colisionarConColectivo() {
        game.say(colectivo, self.mensajeColision())
        const columnas = (0 .. game.width() - 1)
        const bloques = []
        columnas.forEach({ x =>
            const bloque = new VallaBloqueo(position = game.at(x, alturaBloqueo))
            bloque.aparecer()
            bloques.add(bloque)
        })
        game.schedule(8000, { bloques.forEach({ bloque => game.removeVisual(bloque) }) })
        game.removeVisual(self)
    }
}

class ManchaAceite inherits Obstaculo {
    override method image () = "aceite.png"
    override method mensajeColision() = "¡Calle resbaladiza! Ve con cuidado"

    override method colisionarConColectivo() {
        game.say(colectivo, self.mensajeColision())
        colectivo.relentizar()
        self.moverse()
    }
}

class Corazon inherits Obstaculo {
    override method image() = "vida.png"
    override method intervalo() = 7000
    override method mensajeColision() = "¡Gané una vida!"

    override method colisionarConColectivo() {
        game.say(colectivo, self.mensajeColision())
        colectivo.sumarVida()
        self.tiempoDeEspera()
        self.moverse()
    }
}

const pozo = new Pozo(position = game.at(4, 4))
const cabra = new Cabra(position = game.at(10, 10))
const clausura = new ClausuraDeCalle(position = game.at(12, 12))
const manchaAceite = new ManchaAceite(position = game.at(5, 5))
const corazon = new Corazon(position = game.at(8, 8))