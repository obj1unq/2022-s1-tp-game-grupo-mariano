import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*
import gestoresComportamiento.*
import juego.*

class Cazador {

	var property tiempoParaEliminar
	var property cartuchosSoltados
	var property estaVivo

	method puntos() = 0

	method disparar() {
		if (estaVivo) {
			game.sound("escopetazo.mp3").play()
			mira.perdi()
		} else {
		}
	}

}

class Hombre inherits Cazador(tiempoParaEliminar = 6000, cartuchosSoltados = 1, estaVivo = false) {

	var property image = "hombre.png"
	var property position = game.center()

	method aparecer() {
		game.addVisual(self)
		game.schedule(tiempoParaEliminar, { self.disparar()})
	}

}

class Vieja inherits Cazador(tiempoParaEliminar = 2500, cartuchosSoltados = 6, estaVivo = false) {

	var property image = "abuela.png"
	var property position = game.center()

	method aparecer() {
		game.addVisual(self)
		game.schedule(tiempoParaEliminar, { self.disparar()})
	}

}

class Pibe inherits Cazador(tiempoParaEliminar = 4000, cartuchosSoltados = 2, estaVivo = false) {

	var property image = "pibe.png"
	var property position = game.center()

	method aparecer() {
		game.addVisual(self)
		game.schedule(tiempoParaEliminar, { self.disparar()})
	}

}

object gestorCazadores {

	method cazadorAleatorio() {
		const numero = (0 .. 99).anyOne()
		return if (numero > 59 and numero < 94) new Pibe() else if (numero > 93) new Vieja() else if (numero < 60) new Hombre()
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

