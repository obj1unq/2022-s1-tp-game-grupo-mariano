import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import gestoresComportamiento.*
import juego.*

class Puntaje {

	method textColor() = "#1d15b3cc"

}

object tituloPuntuacion inherits Puntaje {

	const property position = game.at(9, 0)

	method text() = "PUNTUACION : "

}

object puntuacion inherits Puntaje {

	var property position = game.at(11, 0)

	method text() = contador.score().printString()

}

object contador {

	var property score = 0

	method sumar(puntos) {
		score = score + puntos
	}

}

