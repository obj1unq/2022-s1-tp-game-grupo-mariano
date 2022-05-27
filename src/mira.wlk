import wollok.game.*

object mira {

	var property position = game.center()

	method image() = "mira2.png"
	
	method mover(direccion) {
		position = direccion.siguiente(self.position()) 
	}
	
	method disparar(){
		game.removeVisual(game.uniqueCollider(self))
	}

}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)
	}

}

object izquierda {

	method siguiente(posicion) {
		return posicion.left(1)
	}

}

object arriba {

	method siguiente(posicion) {
		return posicion.up(1)
	}

}

object abajo {

	method siguiente(posicion) {
		return posicion.down(1)
	}

}