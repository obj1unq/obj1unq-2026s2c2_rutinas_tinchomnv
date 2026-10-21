class ABC {}

// == 1.Personas ==
object running {
    var intensidad = 0 

    method caloriasConsumidas(tiempoEjercicio) {
        return 100 * (tiempoEjercicio - self.descanso(tiempoEjercicio)) * intensidad
    } 

    method seleccionarIntensidad(_intensidad) {
        intensidad = _intensidad
    }

    method descanso(tiempoEjercicio) {
        return if (tiempoEjercicio > 20) { 5 } else { 2 }
    }
}

object maraton {
    var intensidad = 0 

    method caloriasConsumidas(tiempoEjercicio) {
        return (100 * (tiempoEjercicio - self.descanso(tiempoEjercicio)) * intensidad) * 2
    } 

    method seleccionarIntensidad(_intensidad) {
        intensidad = _intensidad
    }

    method descanso(tiempoEjercicio) {
        return if (tiempoEjercicio > 20) { 5 } else { 2 }
    }
}

object remo {
    const intensidad = 1.3 

    method caloriasConsumidas(tiempoEjercicio) {
        return (100 * (tiempoEjercicio - self.descanso(tiempoEjercicio)) * intensidad)
    } 

    method descanso(tiempoEjercicio) {
        return tiempoEjercicio / 5
    }
}

object remoDeCompeticion {
    const intensidad = 1.7

    method caloriasConsumidas(tiempoEjercicio) {
        return (100 * (tiempoEjercicio - self.descanso(tiempoEjercicio)) * intensidad)
    } 

    method descanso(tiempoEjercicio) {
        return ((tiempoEjercicio / 5) - 3).max(2)
    }
}

// == 2.Personas ==
class Persona {
    var peso

    method caloriasPorKilo()
    method tiempoEjercicio() 
    method puedeRealizarRutina(rutina) 

    method asignarPeso(_peso) {
        peso = _peso
    }

    method pesoPerdido(rutina) {
        return rutina.caloriasConsumidas(self.tiempoEjercicio()) / self.caloriasPorKilo()
    }

    method ejercitarRutina(rutina) {
        self.validarPuedeEjercitar(rutina)
        peso -= self.pesoPerdido(rutina)
    }
    
    method validarPuedeEjercitar(rutina) {
        if(not self.puedeRealizarRutina(rutina)) {
            self.error("No se puede realizar la rutina")
        }
    }


}

class PersonaSedentaria inherits Persona{
    var tiempoDeEjercicio = 0
    
    override method caloriasPorKilo() {
        return (7000)
    }

    override method tiempoEjercicio() {
        return tiempoDeEjercicio
    }

    method seleccionarTiempo(_tiempo) {
        tiempoDeEjercicio = _tiempo
    }

    method seleccionarPeso(nuevoPeso) {
        peso = nuevoPeso
    }
    
}

class PersonaAtleta inherits Persona {
    override method caloriasPorKilo() {
        return (8000)
    }

    override method pesoPerdido(rutina) {
        return (rutina.caloriasConsumidas(self.tiempoEjercicio()) / self.caloriasPorKilo()) - 1
    }

    override method tiempoEjercicio() {
        return 90 
    }

    override method puedeRealizarRutina(rutina) {
        return rutina.caloriasConsumidas(self.tiempoEjercicio()) > 10000
    }
}


// == 3.Atletas ==