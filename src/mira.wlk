import wollok.game.*
import balasYCargador.*
import extras.*
import puntuacion.*

object mira {

	var property position = game.center()

	method image() = "mira2.png"
	
	method mover(direccion) {
		return if (self.puedeMover(direccion, position)){
				position = direccion.siguiente(self.position())
			}
			else {}
	}
	
	method puedeMover(direccion, posicion){
		return not direccion.esBorde(posicion)
	}
	
	method disparar(){
		if (balas.hayBalas()){
		game.sound("disparo.mp3").play()
		balas.restarUnaBala()
		self.removerSiHayObjetivo()
		}
		else {game.sound("noMasBalas.mp3").play()}
	}
	
	method removerSiHayObjetivo(){
		return if (game.colliders(self).size() == 1){
			contador.sumar(self.puntosDelObjetivo())
			game.removeVisual(game.uniqueCollider(self))
		} else {}
	}
	
	method puntosDelObjetivo(){
		return game.uniqueCollider(self).puntos()
	}
}

object derecha{

	method siguiente(posicion) {
		return posicion.right(1)
		}
	method esBorde(posicion){
		return posicion.x() == game.width() - 1
	}
}

object izquierda {
	
	method siguiente(posicion){
		return posicion.left(1)
		}
		
	method esBorde(posicion){
		return posicion.x() == 0
	}
}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)
	}
	
	method esBorde(posicion){
		return posicion.y() == game.height() - 1
	}
}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)
	}
	
	method esBorde(posicion){
		return posicion.y() == 0
	}
}