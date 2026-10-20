import Inicioyfin.*


class Obstaculo {
    var property position
    
    method image()
    method mensajeColision()

    method intervalo() = 9000

    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }

    method aparecer() {
        game.addVisual(self)
        game.onTick(self.intervalo(), "movimiento" + self.identity(), { self.moverse() })
        game.onCollideDo(self, { objeto => objeto.chocarCon(self) })    }
    
    method chocarCon(otro) {}

    method colisionarCon(objeto){
		game.removeTickEvent("movimientoColectivo")
		game.say(objeto, self.mensajeColision())
		game.schedule(500, {administrador.perder()})
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

    override method colisionarCon(objeto) {
        if (objeto.vagones().isEmpty()) {
            super(objeto)
        } else {
            objeto.perderVagon()
            self.moverse()
        }
    }
}

class Vip inherits Obstaculo {
    override method image() = "pasajero_vip.png"
    override method intervalo() = 5000
    override method mensajeColision() = "¡Ahora tengo tres colas más!"

    override method colisionarCon(objeto) {
        game.say(objeto, self.mensajeColision())
        objeto.agregarVagones(3)
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

    override method colisionarCon(objeto) {
        game.say(objeto, self.mensajeColision())
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

const pozo = new Pozo(position = game.at(4, 4))
const cabra = new Cabra(position = game.at(10, 10))
const pasajeroVip = new Vip(position = game.at(2, 11))
const clausura = new ClausuraDeCalle(position = game.at(12, 12))