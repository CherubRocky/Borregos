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
    
    public EspectadorRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    /**
     * Obtener todos los espectadores
     */
    public List<Espectador> findAll() {
        String sql = "SELECT * FROM Espectador ORDER BY idespectador";
        return jdbcTemplate.query(sql, new EspectadorRowMapper());
    }
    
    /**
     * Buscar espectador por ID
     */
    public Optional<Espectador> findById(Long id) {
        String sql = "SELECT * FROM Espectador WHERE idespectador = ?";
        List<Espectador> espectadores = jdbcTemplate.query(sql, new EspectadorRowMapper(), id);
        return espectadores.isEmpty() ? Optional.empty() : Optional.of(espectadores.get(0));
    }
    
    /**
     * Crear un nuevo espectador
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
     * Actualizar un espectador existente
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
     * Eliminar un espectador por ID
     */
    public int deleteById(Long id) {
        String sql = "DELETE FROM Espectador WHERE idespectador = ?";
        return jdbcTemplate.update(sql, id);
    }
    
    /**
     * Contar total de espectadores
     */
    public int count() {
        String sql = "SELECT COUNT(*) FROM Espectador";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }
}
