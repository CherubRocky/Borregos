package com.borregos.Practica08.Controller;

import com.borregos.Practica08.Model.Alimento;
import com.borregos.Practica08.Service.AlimentoService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controlador REST de Alimento.
 * Base: /api/alimentos
 */
@RestController
@RequestMapping("/api/alimentos")
public class AlimentoController {

    private final AlimentoService service;

    /**
     * Constructor con la inyección del servicio.
     * @param service servicio de alimentos
     */
    public AlimentoController(AlimentoService service) {
        this.service = service;
    }

    /**
     * GET /api/alimentos
     * @return lista de todos los alimentos
     */
    @GetMapping
    public List<Alimento> listar() {
        return service.listar();
    }

    /**
     * GET /api/alimentos/{id}
     * @param id identificador del alimento
     * @return alimento encontrado
     */
    @GetMapping("/{id}")
    public Alimento obtener(@PathVariable Long id) {
        return service.obtener(id);
    }

    /**
     * POST /api/alimentos (201)
     * @param a cuerpo del alimento válido
     * @return alimento creado
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Alimento crear(@Valid @RequestBody Alimento a) {
        return service.crear(a);
    }

    /**
     * PUT /api/alimentos/{id}
     * @param id identificador a actualizar
     * @param a datos nuevos
     * @return alimento actualizado
     */
    @PutMapping("/{id}")
    public Alimento actualizar(@PathVariable Long id, @Valid @RequestBody Alimento a) {
        return service.actualizar(id, a);
    }

    /**
     * DELETE /api/alimentos/{id} (204)
     * @param id identificador a borrar
     */
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void borrar(@PathVariable Long id) {
        service.borrar(id);
    }

    /**
     * Manejo simple de errores: 400 con el mensaje.
     * @param ex excepción en tiempo de ejecución
     * @return mensaje de error
     */
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(RuntimeException.class)
    public String onRuntime(RuntimeException ex) {
        return ex.getMessage();
    }
}
