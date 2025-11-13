package com.borregos.Practica08.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AlimentoViewController {

    @GetMapping("/alimentos")
    public String alimentos() {
        return "Alimentos";
    }
}