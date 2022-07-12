import wollok.game.*
import mira.*
import balasYCargador.*
import gestoresComportamiento.*


// --------------------------------- SUPERCLASE OBJETOS EXTRAS ------------------------------------ //

class Objetivo{
	var property position = game.at(5,5)
	const property lado = self.deQueLado()
	
	method image() = null
	
	method puntos() = null
	
	method mover(){
		lado.siguiente(self.position())// <--- AGREGADO SOLAMENTE PARA QUE NO MOLESTE WOLLOK CON LA CONSTANTE LADO
	}
	
	method deQueLado() {
		return if (self.position().x() == 0){
		 	derecha
		 } else izquierda
	}
	
	method soyVisible(animal){
		return not animal.lado().fueraDelMapa(animal.position())
	}
}

// ------------------------------------ CLASES ANIMALES Y CAZADORES ---------------------------------------- //
// PATOS-----------
class Pato inherits Objetivo {
	
	override method puntos() = 15
	
	override method image() = "ave_" + lado.toString() + ".png"
	
	override method mover(){
		if (game.hasVisual(self) and self.soyVisible(self)){
			self.position(lado.siguiente(self.position()))
		}
		else {gestorPatos.eliminar(position)}
	}
}

// CIERVOS-----------
 class Ciervo inherits Objetivo {
	
	override method puntos() = 50

	override method image() = "ciervo_" + lado.toString() + ".png"
	
	override method mover(){
		if (game.hasVisual(self)){
			self.position(lado.siguiente(self.position()))
		} else gestorCiervos.eliminar(position)
	}
	
	override method deQueLado() {
		return [derecha, izquierda].anyOne()
	}
}

// TOPOS-----------
class Topo inherits Objetivo {
	
	override method puntos() = 5
	
	override method image() = "topo.png"
	
	override method mover(){
		if (game.hasVisual(self)){
			game.removeVisual(self)
		} else {}
	}
}

// --------------------------------- RANDOMIZADORES DE TIEMPO Y POSICIONES ------------------------------------ //

// TIEMPO-----------
object randomTiempo{
	
	method generar(){
		return (15000.. 35000).anyOne()
	}
}

// POSICIONES GENERAL-----------
class Random{
	
	method position(){
		return game.at(0,0)
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

// POSICIONES CIELO-----------
object randomizerPatos inherits Random {
		
	override method position() {
		return 	game.at( 
					[0, game.width() - 1 ].anyOne(),
					(8..  game.height() - 1).anyOne()
		) 
	}
}

// POSICIONES TIERRA-----------
object randomizerTerrestres inherits Random {
		
	override method position() {
		return 	game.at( 
					(0.. game.width() - 1).anyOne(),
					(1.. 4).anyOne()
		) 
	}
}