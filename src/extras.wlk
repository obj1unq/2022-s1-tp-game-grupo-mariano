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
		if (not lado.esBorde(self.position())) {
			position = lado.siguiente(position)
			game.schedule(randomTiempo.movimiento(), { self.mover()})
		} else {
			self.removerDelJuegoSiPuede(self)
		}
	}
	
	method removerDelJuegoSiPuede(animal) {
		if (game.hasVisual(animal)) {
			game.removeVisual(animal)
		}
	}
	
	method estaVivo(cosa) = false

	method cartuchosSoltados() = 0
	
	method estaEjeXPar() = position.x().even()

}

// ------------------------------------ CLASES ANIMALES Y CAZADORES ---------------------------------------- //
// PATOS-----------
class Pato inherits Objetivo {

	var property puntos = 20

	method image() = lado.imagenDePato(self)

}

// CIERVOS-----------
class Ciervo inherits Objetivo {

	var property puntos = 40

	method image() = lado.imagenDeCiervo(self)

	override method deQueLado() {
		return [ derecha, izquierda ].anyOne()
	}
	

}

// TOPOS-----------
class Topo inherits Objetivo {

	var property puntos = 10

	method image() = "topo.png"

	override method mover() {
		if (game.hasVisual(self)) {
			game.schedule(randomTiempo.generar(), {self.removerDelJuegoSiPuede(self)})
		} else {
		}
	}
	


}

// --------------------------------- RANDOMIZADORES DE TIEMPO Y POSICIONES ------------------------------------ //
// TIEMPO-----------
object randomTiempo {

	method generar() {
		return (1000.1100 .. 2000).anyOne()
	}

	method movimiento() {
		return (100.200 .. 400).anyOne()
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
		return game.at([ 0, game.width() - 1 ].anyOne(), (7 .. game.height() - 1).anyOne())
	}

}

// POSICIONES TIERRA-----------
object randomizerTerrestres inherits Random {

	override method position() {
		return game.at((0 .. game.width() - 1).anyOne(), (1 .. 4).anyOne())
	}

}

