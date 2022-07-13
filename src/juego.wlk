import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*
import gestoresComportamiento.*

object escenario {

	method iniciar() {
		menu.musica().stop()
		game.addVisual(mira)
		game.addVisual(balas)
		game.addVisual(cartucho)
		game.addVisual(tituloPuntuacion)
		game.addVisual(puntuacion)
		config.teclas()
		gestorCiervos.generarCiervos()
		gestorPatos.generarPatos()
		gestorTopos.generarTopos()
		game.onTick(500, "corranCiervitos", { gestorCiervos.mover()})
		game.onTick(800, "vuelenPatos", { gestorPatos.mover()})
		game.onTick(1000, "escandanseTopos", { gestorTopos.mover()})
		game.onTick(0, "sonidoFondoP", { game.sound("bosque.mp3").play()})
		game.onTick(21000, "sonidoFondo", { game.sound("bosque.mp3").play()})
		game.schedule(1, { game.removeTickEvent("sonidoFondoP")})
	}

}

object config {

	method teclas() {
		keyboard.left().onPressDo({ mira.mover(izquierda)})
		keyboard.right().onPressDo({ mira.mover(derecha)})
		keyboard.up().onPressDo({ mira.mover(arriba)})
		keyboard.down().onPressDo({ mira.mover(abajo)})
		keyboard.e().onPressDo({ mira.disparar()})
	}

}

//-----------------------------------------------------PANTALLA INICIO-----------------------------------------//
object pantallaInicio {

	var property position = game.at(0, 0)
	var property image = "fondoinicio.png"

	method poner() {
		game.addVisual(self)
	}

}

object menu {
	
	const property musica = game.sound("musicainicio.mp3")

	const opciones = [ empezar, controles, creditos, salir ]

	method cargarControles() {
		keyboard.up().onPressDo{ selector.mover(arriba)}
		keyboard.down().onPressDo{ selector.mover(abajo)}
		keyboard.enter().onPressDo{ self.opcionSeleccionada().activar()}
		keyboard.space().onPressDo{ self.opcionSeleccionada().salir()}
	}

	method opcionSeleccionada() = opciones.find{ opcion => opcion.estaSeleccionado() }
	
	method reproducirMusica() {
		self.musica().shouldLoop(true)
		game.schedule(300, { musica.play() })
	}
	
}

//---------------------------------OPCIONES-----------------------------//
class Opcion {

	method poner() {
		game.addVisual(self)
	}

	method estaSeleccionado() = selector.position().right(1) == self.position()

	method position()

}

object empezar inherits Opcion {

	var property image = "empezar.png"

	method activar() {
		game.clear()
		escenario.iniciar()
	}

	override method position() = game.at(5, 7)

	method salir() {
	}

}

object controles inherits Opcion {

	var property position = game.at(5, 5)
	var property image = "controles.png"

	method activar() {
		if (not teclas.estanVisibles()) {
			self.mostrarControles()
			teclas.estanVisibles(true)
		}
	}

	method mostrarControles() {
		selector.estoyEnMenu(false)
		game.addVisual(teclas)
	}

	method salir() {
		if (not selector.estoyEnMenu()) {
			game.removeVisual(teclas)
			selector.estoyEnMenu(true)
			teclas.estanVisibles(false)
		}
	}

}

object salir inherits Opcion {

	var property position = game.at(5, 1)
	var property image = "salir.png"

	method activar() {
		game.stop()
	}

	method salir() {
	}

}

object creditos inherits Opcion {

	var property position = game.at(5, 3)
	var property image = "creditos.png"

	method activar() {
		if (not nombres.estanVisibles()) {
			self.mostrarCreditos()
			nombres.estanVisibles(true)
		}
	}

	method mostrarCreditos() {
		selector.estoyEnMenu(false)
		game.addVisual(nombres)
	}

	method salir() {
		if (not selector.estoyEnMenu()) {
			game.removeVisual(nombres)
			selector.estoyEnMenu(true)
			nombres.estanVisibles(false)
		}
	}

}

//-------------------------------------------PANTALLA CREDITOS Y CONTROLES-----------------------------//
object nombres {

	var property position = game.at(0, 0)
	var property image = "fondocreditos.png"
	var property estanVisibles = false

}

object teclas {

	var property position = game.at(0, 0)
	var property image = "fondocontroles.jpg"
	var property estanVisibles = false

}

//-----------------------------------------------------SELECTOR--------------------------------------//
object selector {

	var property image = "selector.png"
	var property position = izquierda.siguiente(empezar.position())
	var property estoyEnMenu = true

	method poner() {
		game.addVisual(self)
	}

	method mover(direccion) {
		if ((not self.estaArriba(direccion) and not self.estaAbajo(direccion)) and estoyEnMenu) {
			position = direccion.dosCeldas(position)
		}
	}

	method estaArriba(direccion) = direccion.siguiente(self.position()).y() == 8

	method estaAbajo(direccion) = direccion.siguiente(self.position()).y() == 0

}

