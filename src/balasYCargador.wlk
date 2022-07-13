import wollok.game.*

object balas {

	const property position = game.at(2, 0)
	var property cantidad = 6

	method image() = "balas" + cantidad.toString() + ".png"

	method hayBalas() {
		return cartucho.quedanCartuchos() || cantidad != 0
	}

	method restarUnaBala() {
		if (cantidad <= 1 && cartucho.quedanCartuchos()) {
			cantidad = 6
			cartucho.restarCartucho()
		} else {
			cantidad = cantidad - 1
		}
	}

	method puntos() = 0

	method cartuchosSoltados() = 0

}

object cartucho {

	const property position = game.at(0, 0)
	var property cantidad = 6

	method image() = "cartucho" + cantidad.toString() + ".png"

	method quedanCartuchos() {
		return cantidad > 0
	}

	method restarCartucho() {
		cantidad = cantidad - 1
	}

	method estaLleno() = cantidad == 6

	method puntos() = 0

	method recargar(cartuchos) {
		if (cartuchos + cantidad >= 6) {
			cantidad = 6
		} else cantidad = cartuchos + cantidad
	}

	method cartuchosSoltados() = 0 

}

