import wollok.game.*
import entidades.*
import obstaculos.*
import direcciones.*
import calles.*

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
    method image() = "calle.png" 
}

object administrador {
    
    method iniciar() {
        game.clear()
        game.addVisual(pantallaInicio) 
        keyboard.space().onPressDo({ self.jugar() })
    }

    method jugar() {
        game.clear() 
        colectivo.reiniciar()
        
        game.addVisual(fondoCalle)

        game.addVisual(colectivo)
        game.addVisual(pasajero)

        keyboard.up().onPressDo({ colectivo.doblar(arriba) })
        keyboard.down().onPressDo({ colectivo.doblar(abajo) })
        keyboard.left().onPressDo({ colectivo.doblar(izquierda) })
        keyboard.right().onPressDo({ colectivo.doblar(derecha) })

        game.onTick(200, "movimientoColectivo", { colectivo.avanzar() })
        game.onTick(6000, "movimientoPasajero", { pasajero.moverse() })
        game.onTick(9000, "movimientoPozo", { pozo.moverse() })

        game.onCollideDo(pasajero, { objeto => pasajero.colisionarCon(colectivo) })
        	
        [pozo, cabra, pasajeroVip, clausura].forEach({ obstaculo => obstaculo.aparecer() })        	        	
        generadorCalles.generar()
    }

    method perder() {
        game.clear()
        game.addVisual(pantallaGameOver) 
        keyboard.space().onPressDo({ self.iniciar() })
    }
}