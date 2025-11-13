package com.borregos.Practica08.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EspectadorViewController {

    /**
     * Muestra la vista de espectadores.
     * @return nombre de la plantilla de la vista de espectadores
     */
    @GetMapping("/espectadores")
    public String espectadores() {
        return "Espectador";
    }
}