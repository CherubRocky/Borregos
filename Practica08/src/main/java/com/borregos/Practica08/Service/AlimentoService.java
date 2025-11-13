package com.borregos.Practica08.Service;

import com.borregos.Practica08.Model.Alimento;
import com.borregos.Practica08.Repository.AlimentoRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.List;

/**
 * Aqui va la Lógica de negocio para Alimento.
 * Aplica las validaciones y usa el repositorio.
 */
@Service
public class AlimentoService {

    private final AlimentoRepository repo;

    /**
     * Crea el servicio.
     * @param repo repositorio de acceso a datos
     */
    public AlimentoService(AlimentoRepository repo) {
        this.repo = repo;
    }

    /**
     * Lista todos los alimentos.
     * @return lista completa
     */
    public List<Alimento> listar() {
        return repo.encuentraTodos();
    }

    /**
     * Obtiene un alimento por id.
     * @param id identificador
     * @return alimento encontrado
     * @throws RuntimeException si no existe
     */
    public Alimento obtener(Long id) {
        return repo.encuentraPorId(id).orElseThrow(() -> new RuntimeException("Alimento no encontrado: " + id));
    }

    /**
     * Crea un alimento.
     * @param a datos a guardar
     * @return alimento creado
     * @throws RuntimeException si falla alguna validación o el id ya existe
     */
    public Alimento crear(Alimento a) {
        validar(a, true);
        if (repo.exists(a.getIdAlimento())) {
            throw new RuntimeException("Ya existe IdAlimento=" + a.getIdAlimento());
        }
        repo.inserta(a);
        return obtener(a.getIdAlimento());
    }

    /**
     * Actualiza un alimento por id.
     * @param id id a actualizar
     * @param a nuevos datos
     * @return alimento actualizado
     * @throws RuntimeException si no existe o falla la validación
     */
    public Alimento actualizar(Long id, Alimento a) {
        validar(a, false);
        if (!repo.exists(id)) throw new RuntimeException("Alimento no encontrado: " + id);
        a.setIdAlimento(id);
        repo.update(a);
        return obtener(id);
    }

    /**
     * Borra un alimento por id.
     * @param id identificador
     * @throws RuntimeException si no existe
     */
    public void borrar(Long id) {
        if (repo.eliminaPorId(id) == 0) {
            throw new RuntimeException("Alimento no encontrado: " + id);
        }
    }

    /**
     * Valida reglas básicas según el DDL.
     * @param a entidad a validar
     * @param crear si es creación (id obligatorio)
     * @throws RuntimeException si alguna regla no se cumple
     */
    private void validar(Alimento a, boolean crear) {
        if (a.getIdAlimento() == null && crear) throw new RuntimeException("IdAlimento requerido (tu DDL no genera identidad)");
        if (!StringUtils.hasText(a.getNombre())) throw new RuntimeException("Nombre no puede ser vacío");
        if (a.getPerecedero() == null) throw new RuntimeException("Perecedero no puede ser null");
        if (Boolean.TRUE.equals(a.getPerecedero())) {
            if (a.getFechaCaducidad() == null || !a.getFechaCaducidad().isAfter(LocalDate.now())) {
                throw new RuntimeException("Si Perecedero=TRUE, entonces FechaCaducidad > hoy");
            }
        }
        if (a.getPrecioSinIVA() == null || a.getPrecioSinIVA().signum() <= 0) {
            throw new RuntimeException("PrecioSinIVA debe ser > 0");
        }
    }
}
