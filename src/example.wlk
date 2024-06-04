class NaveEspacial {
	var velocidad = 0
	var direccion = 0 
	var combustible = 0
	method acelerar(unNumero){
		velocidad = velocidad  + unNumero
		velocidad.max(100000)
	}
	method desacelerar(unNumero){ 
		velocidad = velocidad - unNumero
		velocidad.max(0)
	}
	method irHaciaElSol(){direccion = 10}
	method escaparDelSol(){direccion = -10}
	method ponerseParaleloAlSol(){direccion = 0}
	method acercarseUnPocoAlSol(){direccion = direccion + 1}
	method alejarseUnPocoDelSol(){direccion = direccion - 1}
	method cargarCombustible(numero){combustible = combustible + numero}
	method descargarCombustible(numero){combustible = combustible - numero}
	method estaTranquila() = combustible > 4000 && velocidad < 12000
}

class NavesBaliza inherits NaveEspacial{
	var color 
	method cambiarColorDeBaliza(colorNuevo){color = colorNuevo}
	method prepararViaje(){
		color = "verde"
		self.ponerseParaleloAlSol()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	override method estaTranquila() = super() && color != "Rojo" or color != "rojo"
	method recibirAmenaza(){
		self.irHaciaElSol()
		color = "Rojo"
	}
}

class NavesPasajeros inherits NaveEspacial {
	var property personas
	var property comida = 0
	var property bebida = 0
	method cargarComida(cantidad){comida = comida + cantidad}
	method cargarBebida(cantidad){bebida = bebida + cantidad}
	method prepararViaje(){
		self.cargarComida(4)
		self.cargarBebida(6)
		self.acercarseUnPocoAlSol()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method recibirAmenaza(){
		velocidad = velocidad * 2
		comida = comida - personas
		bebida = bebida - personas * 2
	}
}

class NavesCombate inherits NaveEspacial{
	var estaInvisible
	var estanDesplegadosLosMisiles
	var cantidadDeMensajesEmitidos = 0
	const mensajes = []
	method ponerseVisible(){estaInvisible = false}
	method ponerseInvisible(){estaInvisible = true}
	method estaInvisible() = not estaInvisible
	method desplegarMisiles(){estanDesplegadosLosMisiles = true}
	method replegarMisiles(){estanDesplegadosLosMisiles = false}
	method misilesDesplegados() = not estanDesplegadosLosMisiles
	method emitirMensaje(mensaje){
		cantidadDeMensajesEmitidos = cantidadDeMensajesEmitidos + 1
		mensajes.add(mensaje)
		return mensaje
	}
	method mensajesEmitidos() = cantidadDeMensajesEmitidos
	method ultimoMensajeEmitido() = mensajes.last()
	method primerMensajeEmitido() = mensajes.first()
	method esEscueta() = mensajes.any({mensaje => mensaje.size() > 30})
	method emitioMensaje(mensaje) = mensajes.contains(mensaje)
	method prepararViaje(){
		estaInvisible = false
		estanDesplegadosLosMisiles = true
		self.cargarCombustible(30000)
		self.acelerar(20000)
		return self.emitirMensaje("Saliendo en mision")
	}
	override method estaTranquila() = super() && not estanDesplegadosLosMisiles 
	method recibirAmenaza(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		return self.emitirMensaje("Amenaza recibida")
	}
}

class NavesHospital inherits NavesPasajeros{
	var property estaPreparadoElQuirofano
	override method estaTranquila() = super() && not estaPreparadoElQuirofano
	override method recibirAmenaza(){
		self.irHaciaElSol()
		estaPreparadoElQuirofano = true
	}
}

class NavesSigilosas inherits NavesCombate {
	var property tranquilidad 
	override method estaTranquila() = super() && not estaInvisible
	override method recibirAmenaza(){
		estanDesplegadosLosMisiles = true
		estaInvisible = true
		return super()
	}
}



