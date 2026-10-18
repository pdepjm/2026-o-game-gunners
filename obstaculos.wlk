import Inicioyfin.*


class Obstaculo {
    var property position
    var property image
    var property mensajeColision

    method moverse() {
        const x = 0.randomUpTo(game.width()).truncate(0)
        const y = 0.randomUpTo(game.height()).truncate(0)
        position = game.at(x, y)
    }

    method colisionarCon(objeto){
		game.removeTickEvent("movimientoColectivo")
		game.say(objeto, mensajeColision)
		game.schedule(500, {administrador.perder()})
    }
}

const pozo = new Obstaculo(position = game.at(4, 4), image = "pozo2.png", mensajeColision = "¡Perdí! ¡Me caí en un pozo!")