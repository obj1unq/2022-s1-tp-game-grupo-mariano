import wollok.game.*
import mira.*

class Pato {
	var property position = game.at(5,5)
	const lado = self.deQueLado()
	
	method image() = "ave.png"
	
	method mover(){
		if (game.hasVisual(self)){
			self.position(lado.siguiente(self.position()))
		} else gestorPatos.eliminar(self)
	}
	
	method deQueLado() {
		return if (self.position().x() == 0){
		 	derecha
		 } else izquierda
	}
	
}

object gestorPatos {
	
	const patitos = []

	method generarPatos() {
		const nuevoPato = new Pato(position = randomizer.emptyPosition())
		
		patitos.add(nuevoPato)
		game.addVisual(nuevoPato)
	}
	
	method moverPatos(){
		patitos.forEach({ patito => patito.mover()})
	}
	
	method eliminar(patito) {
		patitos.remove(patito)
		game.removeVisual(patito)
	}
}

object randomizer {
		
	method position() {
		return 	game.at( 
					[0, game.width() - 1 ].anyOne(),
					(5..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}