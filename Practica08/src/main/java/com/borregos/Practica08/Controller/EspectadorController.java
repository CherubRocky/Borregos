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

    /**
     * Constructor principal que inyecta el servicio de {@link Espectador}.
     *
     * @param espectadorService Servicio que maneja la lógica de negocio relacionada con los espectadores.
     */
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
     * Crea un nuevo espectador en la base de datos.
     * <p>
     * Endpoint: <b>POST /api/espectadores</b>
     * </p>
     *
     * @param espectador Objeto {@link Espectador} con los datos a registrar.
     * @return Una respuesta con:
     *         <ul>
     *             <li>201 (Created) y el espectador creado.</li>
     *             <li>400 (Bad Request) si hay errores de validación.</li>
     *             <li>500 (Internal Server Error) si ocurre un error en el servidor.</li>
     *         </ul>
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
     * Actualiza los datos de un espectador existente.
     * <p>
     * Endpoint: <b>PUT /api/espectadores/{id}</b>
     * </p>
     *
     * @param id Identificador del espectador a actualizar.
     * @param espectador Objeto {@link Espectador} con los nuevos datos.
     * @return Una respuesta con:
     *         <ul>
     *             <li>200 (OK) y el espectador actualizado.</li>
     *             <li>400 (Bad Request) si los datos son inválidos.</li>
     *             <li>404 (Not Found) si el espectador no existe.</li>
     *             <li>500 (Internal Server Error) si ocurre un error inesperado.</li>
     *         </ul>
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
     * Elimina un espectador de la base de datos por su identificador.
     * <p>
     * Endpoint: <b>DELETE /api/espectadores/{id}</b>
     * </p>
     *
     * @param id Identificador único del espectador a eliminar.
     * @return Una respuesta con:
     *         <ul>
     *             <li>200 (OK) si el espectador se eliminó correctamente.</li>
     *             <li>404 (Not Found) si el espectador no existe.</li>
     *             <li>500 (Internal Server Error) si ocurre un error en el servidor.</li>
     *         </ul>
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
     * Obtiene la cantidad total de espectadores registrados en el sistema.
     * <p>
     * Endpoint: <b>GET /api/espectadores/count</b>
     * </p>
     *
     * @return Una respuesta con:
     *         <ul>
     *             <li>200 (OK) y el número total de espectadores.</li>
     *             <li>500 (Internal Server Error) si ocurre un error inesperado.</li>
     *         </ul>
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
