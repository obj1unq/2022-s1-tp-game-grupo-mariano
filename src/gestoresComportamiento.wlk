import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*

// ------------------------------------ GESTOR CIERVOS ---------------------------------------- //

object gestorCiervos {

	method generarCiervo() {
		const nuevoCiervo = new Ciervo(position = randomizerTerrestres.emptyPosition())
	
		game.addVisual(nuevoCiervo)
		game.schedule(1500, {self.moverCiervo(nuevoCiervo)})
		game.schedule(randomTiempo.generar(), {self.generarCiervo()})
	}
	
	method moverCiervo(ciervo){
		if (ciervo.soyVisible(ciervo)){
			game.onTick(280, "correCiervin", {ciervo.mover()})
		}
		else {game.removeVisual(ciervo)}
	}	
	
	method eliminar(posicion) {
	}

}
// ------------------------------------ GESTOR PATOS ---------------------------------------- //
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

// ------------------------------------ GESTOR TOPOS ---------------------------------------- //

object gestorTopos {

	method generarTopo() {
		const nuevoTopo = new Topo(position = randomizerTerrestres.emptyPosition())
	
		game.addVisual(nuevoTopo)
		game.schedule(2000, {nuevoTopo.mover()})
		game.schedule(3000, {self.generarTopo()})
	}

}

