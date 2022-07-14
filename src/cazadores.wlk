import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*
import gestoresComportamiento.*
import juego.*

class Cazador {

	var property position = game.center()
	var property estaVivo = false

	method puntos() = 0

	method disparar() {
		if (estaVivo) {
			game.sound("escopetazo.mp3").play()
			mira.perdi()
		} else {
		}
	}

	method aparecer() {
		game.addVisual(self)
		game.schedule(self.tiempoParaEliminar(), { self.disparar()})
	}

	method tiempoParaEliminar()

}

class Hombre inherits Cazador {

	const property cartuchosSoltados = 1
	const property image = "hombre.png"

	override method tiempoParaEliminar() = 6000

}

class Vieja inherits Cazador {

	const property cartuchosSoltados = 6
	const property image = "abuela.png"

	override method tiempoParaEliminar() = 2500

}

class Pibe inherits Cazador {

	const property cartuchosSoltados = 2

	override method tiempoParaEliminar() = 4000

}

object gestorCazadores {

	method cazadorAleatorio() {
		const numero = (0 .. 99).anyOne()
		return if (numero.between(59, 94)) new Pibe() else if (numero > 93) new Vieja() else if (numero < 60) new Hombre()
	}

	method agregar() {
		const cazador = self.cazadorAleatorio()
		return if (not game.hasVisual(cazador)) {
			cazador.position(randomizerTerrestres.position())
			cazador.estaVivo(true)
			cazador.aparecer()
			game.schedule((6000 .. 16000).anyOne(), { self.agregar()})
		} else {
		}
	}

	method generar() {
		game.schedule((6000 .. 16000).anyOne(), { self.agregar()})
	}

}
