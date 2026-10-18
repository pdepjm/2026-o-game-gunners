import wollok.game.*
import entidades.*
import obstaculos.*
import direcciones.*

object pantallaInicio {
    method position() = game.at(0, 0)
    method image() = "pantalla_inicio.png"
}

object pantallaGameOver {
    method position() = game.at(0, 0)
    method image() = "pantalla_gameover.png"
}

object fondoCalle {
    method position() = game.at(0, 0)
    method image() = "calle.png" // Tu imagen de la calle de 15x15
}

object administrador {
    
    method iniciar() {
        game.clear()
        game.addVisual(pantallaInicio) 
        keyboard.space().onPressDo({ self.jugar() })
    }

    method jugar() {
        game.clear() 
        
        game.addVisual(fondoCalle)

        game.addVisual(colectivo)
        game.addVisual(pasajero)
        game.addVisual(pozo)

        keyboard.up().onPressDo({ colectivo.doblar(arriba) })
        keyboard.down().onPressDo({ colectivo.doblar(abajo) })
        keyboard.left().onPressDo({ colectivo.doblar(izquierda) })
        keyboard.right().onPressDo({ colectivo.doblar(derecha) })

        game.onTick(300, "movimientoColectivo", { colectivo.avanzar() })
        game.onTick(6000, "movimientoPasajero", { pasajero.moverse() })
        game.onTick(9000, "movimientoPozo", { pozo.moverse() })

        game.onCollideDo(pasajero, { _ => pasajero.colisionarCon(colectivo) })
        game.onCollideDo(pozo, { _ => pozo.colisionarCon(colectivo) })
    }

    method perder() {
        game.clear()
        game.addVisual(pantallaGameOver) 
        keyboard.space().onPressDo({ self.iniciar() })
    }
}