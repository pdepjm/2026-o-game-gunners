
object perdiste {
    var property position = game.center()
    method image() = "perdiste.png"
}

object arriba {
    const property nombre = "arriba"

    method avanzar(posicion) {
        return posicion.up(1)
    }
}

object abajo {
    const property nombre = "abajo"

    method avanzar(posicion) {
        return posicion.down(1)
    }
}
object izquierda {
    const property nombre = "izquierda"

    method avanzar(posicion) {
        return posicion.left(1)
    }
}

object derecha {
    const property nombre = "derecha"

    method avanzar(posicion) {
        return posicion.right(1)
    }
}