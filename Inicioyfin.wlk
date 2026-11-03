import wollok.game.*
import entidades.*
import obstaculos.*
import direcciones.*
import calles.*
import niveles.*

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
    method chocarCon(otro) {}
}
object fondoParedes {
    method position() = game.at(0, 0)
    method image() = "calle2.png"
    method chocarCon(otro) {}
}

object marcador {
    method position() = game.at(1, 14) 
    method text() = "PUNTOS: " + colectivo.puntaje().toString()
    method textColor() = "FFFF00FF" 
}

object marcadorFinal {
    method position() = game.at(7, 11) 
    method text() = "PUNTAJE FINAL: " + colectivo.puntaje().toString()
    method textColor() = "FFFFFFFF"
}

object administrador {
    var property nivel = nivel1 
    method iniciar() {
        game.clear()
        game.addVisual(pantallaInicio) 
        keyboard.space().onPressDo({ self.jugar(nivel1) })
        keyboard.num1().onPressDo({ self.jugar(nivel1) })
        keyboard.num2().onPressDo({ self.jugar(nivel2) })
    }

    method jugar(nivelElegido) {
        game.clear() 
        nivel = nivelElegido
        colectivo.reiniciar()
        
        game.addVisual(nivel.fondo())
        game.addVisual(marcador)

        game.addVisual(colectivo)
        game.addVisual(pasajero)

        keyboard.up().onPressDo({ colectivo.doblar(arriba) })
        keyboard.down().onPressDo({ colectivo.doblar(abajo) })
        keyboard.left().onPressDo({ colectivo.doblar(izquierda) })
        keyboard.right().onPressDo({ colectivo.doblar(derecha) })

        game.onTick(300, "movimientoColectivo", { colectivo.avanzar() })
        if (nivel.pasajeroSeMueveSolo()) {
        game.onTick(6000, "movimientoPasajero", { pasajero.moverse() })
        }
        game.onTick(9000, "movimientoPozo", { pozo.moverse() })

        game.onCollideDo(pasajero, { objeto => objeto.chocarCon(pasajero) })        	
        
        [pozo, cabra, pasajeroVip, clausura, manchaAceite].forEach({ obstaculo => obstaculo.aparecer() })
        nivel.preparar()

        [pasajero, pozo, cabra, pasajeroVip, clausura, manchaAceite].forEach({ objeto =>
            if (nivel.esPared(objeto.position())) objeto.moverse()
        })
    }

    method perder() {
        game.clear()
        game.addVisual(pantallaGameOver) 
        game.addVisual(marcadorFinal)
        keyboard.space().onPressDo({ self.iniciar() })
    }
}