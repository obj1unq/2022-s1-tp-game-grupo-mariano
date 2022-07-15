import wollok.game.*

class Pistola {

	var cantidad = 6
	
	method image() = cantidad.toString() + ".png"
	
	method llenar() {
		cantidad = 6
	}
	
	method restarUnidad() {
		cantidad = cantidad - 1
	}

}

object balas inherits Pistola {

	const property position = game.at(2, 0)

	override method image() = "balas" + super()

	method hayBalas() {
		return cartucho.quedanCartuchos() or cantidad != 0
	}

	method restarUnaBala() {
		if (cantidad <= 1 and cartucho.quedanCartuchos()) {
			self.llenar()
			cartucho.restarUnidad()
		} else {
			self.restarUnidad()
		}
	}

}

object cartucho inherits Pistola {

	const property  position = game.at(0, 0)

	override method image() = "cartucho" + super()

	method quedanCartuchos() {
		return cantidad > 0
	}

	method sumaDe(cartuchos) = cantidad + cartuchos

	method recargar(cartuchos) {
		if (self.sumaDe(cartuchos) >= 6) {
			self.llenar()
		} else cantidad = self.sumaDe(cartuchos)
	}

}
