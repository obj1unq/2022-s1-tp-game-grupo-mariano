import wollok.game.*
import extras.*
import balasYCargador.*
import puntuacion.*
import gestoresComportamiento.*
import juego.*

object mira {

	var property position = game.center()

	method image() = "mira2.png"

	method perdi() {
		game.clear()
		pantallaMuerte.poner()
		game.schedule(2000, { game.stop()})
	}

	method mover(direccion) {
		return if (not direccion.esBorde(position)) {
			position = direccion.siguiente(position)
		} else {
		}
	}

	method disparar() {
		if (balas.hayBalas()) {
			game.sound("disparo.mp3").play()
			balas.restarUnaBala()
			self.removerSiHayObjetivos()
		} else {
			game.sound("noMasBalas.mp3").play()
		}
	}

	method removerSiHayObjetivos() {
		if (self.hayObjetivos()) {
			contador.sumar(self.puntosDelObjetivo())
			cartucho.recargar(self.balasDelObjetivo())
			self.removerObjetivos()
		} else {
		}
	}

	method removerObjetivos() = self.objetivosDisparados().forEach{ objetivo =>
		game.removeVisual(objetivo)
		objetivo.estaVivo(false)
	}

	method hayObjetivos() = game.colliders(self).size() > 0

	method puntosDelObjetivo() = self.objetivosDisparados().sum{ objetivo => objetivo.puntos() }

	method balasDelObjetivo() = self.objetivosDisparados().sum{ objetivo => objetivo.cartuchosSoltados() }

	method objetivosDisparados() = game.colliders(self)

}

object derecha {

	method siguiente(posicion) {
		return posicion.right(1)
	}

	method esBorde(posicion) {
		return posicion.x() == game.width()
	}

	method imagenDePato(pato) = if (pato.estaEjeXPar()) "patoder1.png" else "patoder2.png"

	method imagenDeCiervo(ciervo) = if (ciervo.estaEjeXPar()) "ciervoder1.png" else "ciervoder2.png"

}

object izquierda {

	method siguiente(posicion) {
		return posicion.left(1)
	}

	method esBorde(posicion) {
		return posicion.x() == -1
	}

	method imagenDePato(pato) = if (pato.estaEjeXPar()) "patoizq1.png" else "patoizq2.png"

	method imagenDeCiervo(ciervo) =  if (ciervo.estaEjeXPar()) "ciervoizq1.png" else "ciervoizq2.png"
}

object arriba {

	method dosCeldas(posicion) {
		return posicion.up(2)
	}

	method siguiente(posicion) {
		return posicion.up(1)
	}

	method esBorde(posicion) {
		return posicion.y() == game.height() - 1
	}

}

object abajo {

	method dosCeldas(posicion) {
		return posicion.down(2)
	}

	method siguiente(posicion) {
		return posicion.down(1)
	}

	method esBorde(posicion) {
		return posicion.y() == 1
	}

}

