package com.borregos.Practica08.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AlimentoViewController {

    /**
     * Muestra la vista de alimentos.
     * @return nombre de la plantilla de la vista de alimentos
     */
    @GetMapping("/alimentos")
    public String alimentos() {
        return "Alimentos";
    }
}