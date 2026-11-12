object arriba {
    const property nombre = "arriba"

    method avanzar(posicion) {
        return posicion.up(1)
    }

    method opuesta() = abajo
}

object abajo {
    const property nombre = "abajo"

    method avanzar(posicion) {
        return posicion.down(1)
    }

    method opuesta() = arriba
}
object izquierda {
    const property nombre = "izquierda"

    method avanzar(posicion) {
        return posicion.left(1)
    }

    method opuesta() = derecha
}

object derecha {
    const property nombre = "derecha"

    method avanzar(posicion) {
        return posicion.right(1)
    }

    method opuesta() = izquierda
}