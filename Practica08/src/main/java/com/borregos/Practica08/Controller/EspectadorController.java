package com.borregos.Practica08.controller;

import com.borregos.Practica08.model.Espectador;
import com.borregos.Practica08.service.EspectadorService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

/**
 * Controlador REST para Espectador
 * Expone endpoints para operaciones CRUD
 */
@RestController
@RequestMapping("/api/espectadores")
public class EspectadorController {
    
    private final EspectadorService espectadorService;
    
    public EspectadorController(EspectadorService espectadorService) {
        this.espectadorService = espectadorService;
    }
    
    /**
     * GET /api/espectadores
     * Obtener todos los espectadores
     */
    @GetMapping
    public ResponseEntity<List<Espectador>> getAllEspectadores() {
        try {
            List<Espectador> espectadores = espectadorService.getAllEspectadores();
            if (espectadores.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(espectadores);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    /**
     * GET /api/espectadores/{id}
     * Obtener un espectador por ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<Espectador> getEspectadorById(@PathVariable Long id) {
        try {
            Optional<Espectador> espectador = espectadorService.getEspectadorById(id);
            return espectador.map(ResponseEntity::ok)
                            .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    /**
     * POST /api/espectadores
     * Crear un nuevo espectador
     */
    @PostMapping
    public ResponseEntity<?> createEspectador(@RequestBody Espectador espectador) {
        try {
            Espectador nuevoEspectador = espectadorService.createEspectador(espectador);
            return ResponseEntity.status(HttpStatus.CREATED).body(nuevoEspectador);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Error al crear el espectador: " + e.getMessage());
        }
    }
    
    /**
     * PUT /api/espectadores/{id}
     * Actualizar un espectador existente
     */
    @PutMapping("/{id}")
    public ResponseEntity<?> updateEspectador(@PathVariable Long id, 
                                              @RequestBody Espectador espectador) {
        try {
            Espectador actualizado = espectadorService.updateEspectador(id, espectador);
            return ResponseEntity.ok(actualizado);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (RuntimeException e) {
            if (e.getMessage().contains("no encontrado")) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Error al actualizar: " + e.getMessage());
        }
    }
    
    /**
     * DELETE /api/espectadores/{id}
     * Eliminar un espectador
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEspectador(@PathVariable Long id) {
        try {
            espectadorService.deleteEspectador(id);
            return ResponseEntity.ok("Espectador eliminado correctamente");
        } catch (RuntimeException e) {
            if (e.getMessage().contains("no encontrado")) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Error al eliminar: " + e.getMessage());
        }
    }
    
    /**
     * GET /api/espectadores/count
     * Obtener cantidad total de espectadores
     */
    @GetMapping("/count")
    public ResponseEntity<Integer> countEspectadores() {
        try {
            int count = espectadorService.countEspectadores();
            return ResponseEntity.ok(count);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
