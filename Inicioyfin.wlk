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

object pantallaConVidas {
    method position() = game.at(0, 0)
    method image() = "pantalla_con_vidas.png"
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
    method chocarCon(otro) {}
}

object marcadorFinal {
    method position() = game.at(7, 11)
    method text() = "PUNTAJE FINAL: " + colectivo.puntaje().toString()
    method textColor() = "FFFFFFFF"
}

object marcadorVidas {
    method position() = game.at(6, 14)
    method text() = "VIDAS: " + colectivo.vidas().toString()
    method textColor() = "FF5050FF"
    method chocarCon(otro) {}
}
object marcadorVidasFinal {
    method position() = game.at(7, 10) 
    method text() = "VIDAS: " + colectivo.vidas().toString()
    method textColor() = "FF5050FF"
}

object administrador {
    var property nivel = nivel1
    method iniciar() {
        game.clear()
        game.addVisual(pantallaInicio) 
        keyboard.num1().onPressDo({ self.jugar(nivel1) })
        keyboard.num2().onPressDo({ self.jugar(nivel2) })
    }

    method jugar(nivelElegido) {
        nivel = nivelElegido
        colectivo.reiniciar()
        self.armarPartida()
    }

    method continuarConVida() {
        colectivo.gastarVida()
        self.armarPartida()
    }
    
    method armarPartida() {
        game.clear() 
        
        game.addVisual(nivel.fondo())
        game.addVisual(marcador)
        game.addVisual(marcadorVidas)

        game.addVisual(colectivo)
        colectivo.vagones().forEach({ vagon => game.addVisual(vagon) })
        game.addVisual(pasajero)
        game.addVisual(pasajeroVip)

        keyboard.up().onPressDo({ colectivo.doblar(arriba) })
        keyboard.down().onPressDo({ colectivo.doblar(abajo) })
        keyboard.left().onPressDo({ colectivo.doblar(izquierda) })
        keyboard.right().onPressDo({ colectivo.doblar(derecha) })

        game.onTick(colectivo.velocidad(), "movimientoColectivo", { colectivo.avanzar() })
        if (nivel.pasajeroSeMueveSolo()) {
            game.onTick(6000, "movimientoPasajeros", { pasajero.moverse(); pasajeroVip.moverse() })
        }

        game.onTick(9000, "movimientoPozo", { pozo.moverse() })

        game.onCollideDo(pasajero, { objeto => objeto.chocarCon(pasajero) })    
        game.onCollideDo(pasajeroVip, { objeto => objeto.chocarCon(pasajeroVip) })        	
        
        [pozo, cabra, clausura, manchaAceite, corazon].forEach({ obstaculo => obstaculo.aparecer() })
        nivel.preparar()

        [pasajero, pozo, cabra, clausura, manchaAceite, corazon].forEach({ objeto =>
            if (nivel.esPared(objeto.position())) objeto.moverse()
        })
    }

    method perder() {
        game.clear()
        if (colectivo.tieneVidas()) {
            game.addVisual(pantallaConVidas)
            game.addVisual(marcadorFinal)
            game.addVisual(marcadorVidasFinal)
            keyboard.space().onPressDo({ self.iniciar() game.addVisual(pantallaGameOver) })
            keyboard.r().onPressDo({ self.continuarConVida() })
        } else {
            game.addVisual(pantallaGameOver)
            game.addVisual(marcadorFinal)
            game.addVisual(marcadorVidasFinal)
            keyboard.space().onPressDo({ self.iniciar() })
        }
    }
}