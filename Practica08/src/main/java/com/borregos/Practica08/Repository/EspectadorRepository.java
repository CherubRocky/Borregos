package com.borregos.Practica08.repository;

import com.borregos.Practica08.mapper.EspectadorRowMapper;
import com.borregos.Practica08.model.Espectador;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.Time;
import java.util.List;
import java.util.Optional;

/**
 * Repositorio para operaciones CRUD de Espectador
 */
@Repository
public class EspectadorRepository {
    
    private final JdbcTemplate jdbcTemplate;

     /**
     * Constructor que inyecta la dependencia de {@link JdbcTemplate}.
     *
     * @param jdbcTemplate instancia de {@code JdbcTemplate} proporcionada por Spring.
     */
    public EspectadorRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
     /**
     * Obtiene todos los registros de la tabla {@code Espectador}.
     *
     * @return lista con todos los espectadores registrados.
     */
    public List<Espectador> findAll() {
        String sql = "SELECT * FROM Espectador ORDER BY idespectador";
        return jdbcTemplate.query(sql, new EspectadorRowMapper());
    }
    
     /**
     * Busca un espectador por su identificador único.
     *
     * @param id identificador del espectador a buscar.
     * @return un {@link Optional} que contiene el espectador encontrado,
     * o vacío si no existe un registro con ese ID.
     */
    public Optional<Espectador> findById(Long id) {
        String sql = "SELECT * FROM Espectador WHERE idespectador = ?";
        List<Espectador> espectadores = jdbcTemplate.query(sql, new EspectadorRowMapper(), id);
        return espectadores.isEmpty() ? Optional.empty() : Optional.of(espectadores.get(0));
    }
    
    /**
     * Inserta un nuevo registro en la tabla {@code Espectador}.
     *
     * @param espectador objeto {@link Espectador} que contiene los datos a insertar.
     * @return número de filas afectadas (1 si la inserción fue exitosa).
     */
    public int save(Espectador espectador) {
        String sql = "INSERT INTO Espectador (idespectador, nombre, paterno, materno, " +
                     "fechanacimiento, genero, horaingreso, horasalida) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        return jdbcTemplate.update(sql,
            espectador.getIdEspectador(),
            espectador.getNombre(),
            espectador.getPaterno(),
            espectador.getMaterno(),
            espectador.getFechaNacimiento() != null ? Date.valueOf(espectador.getFechaNacimiento()) : null,
            espectador.getGenero() != null ? espectador.getGenero().toString() : null,
            espectador.getHoraIngreso() != null ? Time.valueOf(espectador.getHoraIngreso()) : null,
            espectador.getHoraSalida() != null ? Time.valueOf(espectador.getHoraSalida()) : null
        );
    }
    
    /**
     * Actualiza los datos de un espectador existente identificado por su ID.
     *
     * @param id identificador del espectador a actualizar.
     * @param espectador objeto {@link Espectador} con los nuevos valores.
     * @return número de filas modificadas (1 si la actualización fue exitosa).
     */
    public int update(Long id, Espectador espectador) {
        String sql = "UPDATE Espectador SET nombre = ?, paterno = ?, materno = ?, " +
                     "fechanacimiento = ?, genero = ?, horaingreso = ?, horasalida = ? " +
                     "WHERE idespectador = ?";
        
        return jdbcTemplate.update(sql,
            espectador.getNombre(),
            espectador.getPaterno(),
            espectador.getMaterno(),
            espectador.getFechaNacimiento() != null ? Date.valueOf(espectador.getFechaNacimiento()) : null,
            espectador.getGenero() != null ? espectador.getGenero().toString() : null,
            espectador.getHoraIngreso() != null ? Time.valueOf(espectador.getHoraIngreso()) : null,
            espectador.getHoraSalida() != null ? Time.valueOf(espectador.getHoraSalida()) : null,
            id
        );
    }
    
    /**
     * Elimina un registro de la tabla {@code Espectador} según su ID.
     *
     * @param id identificador del espectador a eliminar.
     * @return número de filas eliminadas (1 si la eliminación fue exitosa).
     */
    public int deleteById(Long id) {
        String sql = "DELETE FROM Espectador WHERE idespectador = ?";
        return jdbcTemplate.update(sql, id);
    }
    
     /**
     * Obtiene el número total de espectadores registrados en la tabla.
     *
     * @return cantidad total de registros en {@code Espectador}.
     */
    public int count() {
        String sql = "SELECT COUNT(*) FROM Espectador";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }
}
