import wollok.game.*
import Inicioyfin.*
import calles.*
import entidades.*

object nivel1 {
    method fondo() = fondoCalle
    method posicionInicial() = game.at(1, 1)
    method pasajeroSeMueveSolo() = true

    method preparar() {
        generadorCalles.generar()
    }

    method esPared(posicion) = false

    method posicionAleatoria() =
        game.at(0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0))
}

object nivel2 {
    method fondo() = fondoParedes
    method posicionInicial() = game.at(2, 2)
    method pasajeroSeMueveSolo() = false
    method preparar() {}

    method esPared(posicion) =
        posicion.x() <= 0 or posicion.x() >= game.width() - 1 or
        posicion.y() <= 0 or posicion.y() >= game.height() - 1

    method posicionAleatoria() =
        game.at(1.randomUpTo(game.width() - 1).truncate(0), 1.randomUpTo(game.height() - 1).truncate(0))
}
