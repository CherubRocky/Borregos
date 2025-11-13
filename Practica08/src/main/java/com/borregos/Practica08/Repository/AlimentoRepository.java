package com.borregos.Practica08.Repository;

import com.borregos.Practica08.Model.Alimento;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repositorio JDBC para nuestra tabla Alimento.
 */
@Repository
public class AlimentoRepository {

    private final JdbcTemplate jdbc;

    /**
     * Creamos el repositorio con JdbcTemplate.
     * @param jdbc template JDBC
     */
    public AlimentoRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    // SELECT base (PrecioSinIVA como numeric para mapear a BigDecimal)
    private static final String SELECT_BASE = """
        SELECT IdAlimento,
               Nombre,
               FechaCaducidad,
               Perecedero,
               (PrecioSinIVA::numeric) AS PrecioSinIVA
        FROM Alimento
        """;

    /**
     * Obtiene todos los alimentos.
     * @return La lista esta ordenada por IdAlimento
     */
    public List<Alimento> encuentraTodos() {
        return jdbc.query(SELECT_BASE + " ORDER BY IdAlimento", new AlimentoRowMapper());
    }

    /**
     * Busca un alimento por id.
     * @param id identificador
     * @return El alimento si existe
     */
    public Optional<Alimento> encuentraPorId(Long id) {
        try {
            Alimento a = jdbc.queryForObject(
                SELECT_BASE + " WHERE IdAlimento = ?",
                new AlimentoRowMapper(), id
            );
            return Optional.ofNullable(a);
        } catch (EmptyResultDataAccessException e) {
            return Optional.empty();
        }
    }

    /**
     * Inserta un alimento.
     * @param a entidad a insertar
     * @return filas que estan involucradas
     */
    public int inserta(Alimento a) {
        String sql = """
            INSERT INTO Alimento (IdAlimento, Nombre, FechaCaducidad, Perecedero, PrecioSinIVA)
            VALUES (?, ?, ?, ?, CAST(? AS money))
            """;
        return jdbc.update(sql,
                a.getIdAlimento(),
                a.getNombre(),
                a.getFechaCaducidad(),
                a.getPerecedero(),
                a.getPrecioSinIVA()
        );
    }

    /**
     * Actualiza un alimento por id.
     * @param a entidad con los datos nuevos
     * @return filas afectadas
     */
    public int update(Alimento a) {
        String sql = """
            UPDATE Alimento
               SET Nombre = ?,
                   FechaCaducidad = ?,
                   Perecedero = ?,
                   PrecioSinIVA = CAST(? AS money)
             WHERE IdAlimento = ?
            """;
        return jdbc.update(sql,
                a.getNombre(),
                a.getFechaCaducidad(),
                a.getPerecedero(),
                a.getPrecioSinIVA(),
                a.getIdAlimento()
        );
    }

    /**
     * Elimina un alimento por id.
     * @param id identificador
     * @return filas que se eliminaron
     */
    public int eliminaPorId(Long id) {
        String sql = "DELETE FROM Alimento WHERE IdAlimento = ?";
        return jdbc.update(sql, id);
    }

    /**
     * Verifica existencia por id.
     * @param id identificador
     * @return true en caso de que si existe
     */
    public boolean exists(Long id) {
        Integer x = jdbc.queryForObject("SELECT COUNT(*) FROM Alimento WHERE IdAlimento = ?", Integer.class, id);
        return x != null && x > 0;
    }
}
