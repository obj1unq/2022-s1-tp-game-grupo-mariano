import wollok.game.*
import mira.*
import extras.*
import balasYCargador.*
import puntuacion.*
import gestoresComportamiento.*
import cazadores.*

object escenario {
	
	const musicaJuego = game.sound("Bosque.mp3")

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
		gestorCazadores.generar()
		musicaJuego.shouldLoop(true)
		game.schedule(300, { musicaJuego.play()})
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
class Pantalla {

	var property position = game.at(0, 0)

	method poner() {
		game.addVisual(self)
	}

}

object pantallaInicio inherits Pantalla {

	var property image = "fondoinicio.png"

}

object pantallaMuerte inherits Pantalla {

	var property image = "fondogameover.png"

}

object menu {

	const property musica = game.sound("musicainicio.mp3")
	const opciones = [ empezar, controles, creditos, salir ]

	method cargarControles() {
		keyboard.up().onPressDo{ selector.mover(arriba)}
		keyboard.down().onPressDo{ selector.mover(abajo)}
		keyboard.enter().onPressDo{ self.opcionSeleccionada().activar(self.visualesSeleccion())}
		keyboard.space().onPressDo{ self.opcionSeleccionada().salir(self.visualesSeleccion())}
	}

	method opcionSeleccionada() = opciones.find{ opcion => opcion.estaSeleccionado() }

	method visualesSeleccion() = self.opcionSeleccionada().visuales()

	method reproducirMusica() {
		self.musica().shouldLoop(true)
		game.schedule(300, { musica.play()})
	}

}

//---------------------------------OPCIONES-----------------------------//
class Opcion {

	method poner() {
		game.addVisual(self)
	}

	method estaSeleccionado() = selector.position().right(1) == self.position()

	method position()

	method activar(eleccion) {
		if (not eleccion.estanVisibles()) {
			eleccion.estanVisibles(true)
			self.mostrar(eleccion)
		}
	}

	method mostrar(eleccion) {
		selector.estoyEnMenu(false)
		game.addVisual(eleccion)
	}

	method salir(eleccion) {
		if (not selector.estoyEnMenu()) {
			game.removeVisual(eleccion)
			selector.estoyEnMenu(true)
			eleccion.estanVisibles(false)
		}
	}

	method visuales() = null

}

object empezar inherits Opcion {

	method image() = "empezar.png"

	override method position() = game.at(5, 7)

	override method activar(eleccion) {
		game.clear()
		escenario.iniciar()
	}

	method salir() {
	}

}

object controles inherits Opcion {

	override method position() = game.at(5, 5)

	method image() = "controles.png"

	override method visuales() = teclas

}

object creditos inherits Opcion {

	var property position = game.at(5, 3)
	var property image = "creditos.png"

	override method visuales() = nombres

}

object salir inherits Opcion {

	override method position() = game.at(5, 1)

	method image() = "salir.png"

	override method activar(eleccion) {
		game.stop()
	}

	method salir() {
	}

}

//-------------------------------------------PANTALLA CREDITOS Y CONTROLES-----------------------------//
object nombres {

	var property estanVisibles = false

	method position() = game.at(0, 0)

	method image() = "fondocreditos.png"

}

object teclas {

	var property estanVisibles = false

	method position() = game.at(0, 0)

	method image() = "fondocontroles.jpg"

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
