import wollok.game.*
import mira.*
import balasYCargador.*

class Objetivo{
	var property position = game.at(5,5)
	const lado = self.deQueLado()
	
	method image() = null
	
	method puntos(){
		return null
	}
	
	method mover(){
		lado.siguiente(self.position())
	}
	
	method deQueLado() {
		return if (self.position().x() == 0){
		 	derecha
		 } else izquierda
	}
}

class Pato inherits Objetivo {
	
	override method puntos() = 5
	
	override method image() = "ave_" + lado.toString() + ".png"
	
	override method mover(){
		if (game.hasVisual(self)){
			self.position(lado.siguiente(self.position()))
		}
		else {gestorPatos.eliminar(position)}
	}
}

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

object gestorCiervos {
	
	//const ciervitos = []

	method generarCiervos() {
		const nuevoCiervo = new Ciervo(position = randomizerCiervos.emptyPosition())
	
		//ciervitos.add(nuevoCiervo)
		game.addVisual(nuevoCiervo)
		game.schedule(1500, {self.moverCiervos(nuevoCiervo)})
		game.schedule(randomTiempo.generar(), {self.generarCiervos()})
	}
	
	method moverCiervos(ciervo){
		game.onTick(300, "correCiervin", {ciervo.mover()})
//		ciervitos.forEach({ ciervito => ciervito.mover()})
	}

	method eliminar(posicion) {
		//ciervitos.filter({ciervito=> ciervito.position() != posicion})
	}

}

object gestorPatos {
	
	const patitos = []

	method generarPatos() {
		const nuevoPato = new Pato(position = randomizerPatos.emptyPosition())
		
		patitos.add(nuevoPato)
		game.addVisual(nuevoPato)
	}
	
	method moverPatos(){
		patitos.forEach({ patito => patito.mover()})
	}
	
	method eliminar(posicion) {
		patitos.filter({patito=> patito.position() != posicion})
	}

}

object randomTiempo{
	
	method generar(){
		return (15000.. 35000).anyOne()
	}
}

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

object randomizerPatos inherits Random {
		
	override method position() {
		return 	game.at( 
					[0, game.width() - 1 ].anyOne(),
					(8..  game.height() - 1).anyOne()
		) 
	}
}

object randomizerCiervos inherits Random {
		
	override method position() {
		return 	game.at( 
					(0.. game.width() - 1).anyOne(),
					(1.. 4).anyOne()
		) 
	}
}