import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import gestoresComportamiento.*
import juego.*


object tituloPuntuacion {
	var property position = game.at(9,0)
	
	method text() = "PUNTUACION : "
	
	method textColor() = "#1d15b3cc"
	
	method puntos() = 0
	
	method cartuchosSoltados() = 0
}

object puntuacion {
	var property position = game.at(11,0)

	method text() = contador.score().printString()
	
	method textColor() = "#1d15b3cc"
	
	method puntos() = 0
	
	method cartuchosSoltados() = 0
}


object contador{
	var property score = 0
	
	method sumar(puntos){
		score = score + puntos
	}
	
	method puntos() = 0
	
	method cartuchosSoltados() = 0
}
