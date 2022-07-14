import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*

//---------------------------------------GESTOR SUPERCLASE-----------------------------------------//
class Gestor {

	const animalitos = []

	method agregar() {
		const animal = self.generar()
		animalitos.add(animal)
		game.addVisual(animal)
	}

	method generar()

	method mover() {
		animalitos.forEach({ animal => game.schedule(randomTiempo.movimiento(), { animal.mover()})})
	}

	method eliminar(posicion) {
		animalitos.removeAllSuchThat{ animal => animal.position() == posicion}
	}

}

// ------------------------------------ GESTOR CIERVOS ---------------------------------------- //
object gestorCiervos inherits Gestor {

	override method generar() = new Ciervo(position = randomizerTerrestres.emptyPosition())

	method generarCiervos() {
		game.onTick(randomTiempo.generar(), "crearCiervos", { self.agregar()})
	}

}

// ------------------------------------ GESTOR PATOS ---------------------------------------- //
object gestorPatos inherits Gestor {

	override method generar() = new Pato(position = randomizerPatos.emptyPosition())

	method generarPatos() {
		game.onTick(2500, "crearPatos", { self.agregar()})
	}

}

// ------------------------------------ GESTOR TOPOS ---------------------------------------- //
object gestorTopos inherits Gestor {

	override method generar() = new Topo(position = randomizerTerrestres.emptyPosition())

	method generarTopos() {
		game.onTick(randomTiempo.generar(), "crearTopos", { self.agregar()})
	}

}








