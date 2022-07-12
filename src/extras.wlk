import wollok.game.*
import mira.*
import balasYCargador.*
import gestoresComportamiento.*

// --------------------------------- SUPERCLASE OBJETOS EXTRAS ------------------------------------ //
class Objetivo {

	var property position
	const lado = self.deQueLado()

	method deQueLado() {
		return if (self.position().x() == 0) {
			derecha
		} else izquierda
	}

	method mover() {
		if (game.hasVisual(self)) {
			position = lado.siguiente(position)
		} else {
			self.salirDelJuego(position)
		}
	}

	method salirDelJuego(posicion)

}

// ------------------------------------ CLASES ANIMALES Y CAZADORES ---------------------------------------- //
// PATOS-----------
class Pato inherits Objetivo {

	var property puntos = 5

	method image() = lado.imagenDePato()

	override method salirDelJuego(posicion) {
		gestorPatos.eliminar(posicion)
	}

}

// CIERVOS-----------
class Ciervo inherits Objetivo {

	var property puntos = 50

	method image() = lado.imagenDeCiervo()

	override method salirDelJuego(posicion) {
		gestorCiervos.eliminar(posicion)
	}

	override method deQueLado() {
		return [ derecha, izquierda ].anyOne()
	}

}

// TOPOS-----------
class Topo inherits Objetivo {

	var property puntos = 5

	method image() = "topo.png"

	override method mover() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		} else {
		}
	}

	override method salirDelJuego(posicion) {
		gestorTopos.eliminar(posicion)
	}

}

// --------------------------------- RANDOMIZADORES DE TIEMPO Y POSICIONES ------------------------------------ //
// TIEMPO-----------
object randomTiempo {

	method generar() {
		return (2000.2100 .. 3000).anyOne()
	}

}

// POSICIONES GENERAL-----------
class Random {

	method position()

	method emptyPosition() {
		const position = self.position()
		if (game.getObjectsIn(position).isEmpty()) {
			return position
		} else {
			return self.emptyPosition()
		}
	}

}

// POSICIONES CIELO-----------
object randomizerPatos inherits Random {

	override method position() {
		return game.at([ 0, game.width() - 1 ].anyOne(), (8 .. game.height() - 1).anyOne())
	}

}

// POSICIONES TIERRA-----------
object randomizerTerrestres inherits Random {

	override method position() {
		return game.at((0 .. game.width() - 1).anyOne(), (1 .. 4).anyOne())
	}

}

