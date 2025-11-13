package com.borregos.Practica08.Repository;

import com.borregos.Practica08.Model.Alimento;
import org.springframework.jdbc.core.RowMapper;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

/**
 * Mapea una fila a {@link Alimento}.
 */
public class AlimentoRowMapper implements RowMapper<Alimento> {

    /**
     * Convierte la fila actual del ResultSet en un Alimento.
     * @param rs cursor de resultados
     * @param rowNum número de fila (0..n)
     * @return entidad Alimento
     * @throws SQLException si hay error al leer alguna columna
     */
    @Override
    public Alimento mapRow(ResultSet rs, int rowNum) throws SQLException {
        Alimento a = new Alimento();
        a.setIdAlimento(rs.getLong("IdAlimento"));
        a.setNombre(rs.getString("Nombre"));

        LocalDate f = rs.getObject("FechaCaducidad", LocalDate.class);
        a.setFechaCaducidad(f);

        Boolean p = (Boolean) rs.getObject("Perecedero");
        a.setPerecedero(p);

        BigDecimal precio = rs.getBigDecimal("PrecioSinIVA");
        a.setPrecioSinIVA(precio);

        return a;
        }
}
