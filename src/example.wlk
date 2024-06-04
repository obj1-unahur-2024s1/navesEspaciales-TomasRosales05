class NaveEspacial {
	var velocidad = 0
	var direccion = 0 
	var combustible = 0
	method acelerar(unNumero){
		velocidad = 100000.min(velocidad  + unNumero)
	}
	method desacelerar(unNumero){ 
		velocidad = 0.max(velocidad - unNumero)
	}
	method irHaciaElSol(){direccion = 10}
	method escaparDelSol(){direccion = -10}
	method ponerseParaleloAlSol(){direccion = 0}
	method acercarseUnPocoAlSol(){direccion = (10).min(direccion + 1)}
	method alejarseUnPocoDelSol(){direccion = (-10).max(direccion - 1)}
	method cargarCombustible(numero){combustible = combustible + numero}
	method descargarCombustible(numero){combustible = combustible - numero}
	method estaTranquila() = combustible > 4000 && velocidad < 12000
	method prepararViaje()
	method initialize(){
		if(not direccion.between(-10,10)){
			self.error("direccion incorrecta")
		}
		else if(not velocidad.between(0,100000)){
			self.error("direccion incorrecta")
		}
		else{}
	}
}

class NavesBaliza inherits NaveEspacial{
	var color 
	method cambiarColorDeBaliza(colorNuevo){
		self.validarColores(colorNuevo)
		color = colorNuevo
	}
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	override method estaTranquila() = super() && color != "rojo"
	method recibirAmenaza(){
		self.irHaciaElSol()
		color = "rojo"
	}
	method initialize(){
		self.validarColores(color)
	}
	
	method validarColores(unColor) {
		if(["rojo","verde","azul"].contains(unColor))
			self.error("color incorrecto")
	}
}

class NavesPasajeros inherits NaveEspacial {
	var property personas
	var  comida = 0
	var  bebida = 0
	method bebida()=bebida
	method comida()= comida
	method cargarComida(cantidad){comida = comida + cantidad}
	method cargarBebida(cantidad){bebida = bebida + cantidad}
	method descargarComida(cantidad){comida = comida - cantidad}
	method descargarBebida(cantidad){bebida = bebida - cantidad}
	override method prepararViaje(){
		self.cargarComida(4 * personas)
		self.cargarBebida(6 * personas)
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
	var estaInvisible = false
	var estanDesplegadosLosMisiles = true
	const mensajes = []
	method ponerseVisible(){estaInvisible = false}
	method ponerseInvisible(){estaInvisible = true}
	method estaInvisible() = not estaInvisible
	method desplegarMisiles(){estanDesplegadosLosMisiles = true}
	method replegarMisiles(){estanDesplegadosLosMisiles = false}
	method misilesDesplegados() = not estanDesplegadosLosMisiles
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
		return mensaje
	}
	method mensajesEmitidos() = mensajes.size()
	method ultimoMensajeEmitido() = mensajes.last()
	method primerMensajeEmitido() = mensajes.first()
	method esEscueta() = mensajes.any({mensaje => mensaje.size() > 30})
	method emitioMensaje(mensaje) = mensajes.contains(mensaje)
	override method prepararViaje(){
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



