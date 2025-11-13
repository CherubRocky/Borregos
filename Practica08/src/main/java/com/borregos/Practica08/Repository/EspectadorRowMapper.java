package com.borregos.Practica08.Repository;

import com.borregos.Practica08.Model.Espectador;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Mapper para convertir ResultSet de base de datos a objetos Espectador
 */
public class EspectadorRowMapper implements RowMapper<Espectador> {

     /**
     * Convierte una fila del {@link ResultSet} en una instancia del modelo {@link Espectador}.
     *
     * @param rs objeto {@link ResultSet} que contiene los datos de la consulta SQL.
     * @param rowNum número de la fila actual procesada por el {@link RowMapper}.
     * @return un objeto {@link Espectador} con los datos mapeados desde la base de datos.
     * @throws SQLException si ocurre un error al acceder a las columnas del {@code ResultSet}.
     */
    @Override
    public Espectador mapRow(ResultSet rs, int rowNum) throws SQLException {
        Espectador espectador = new Espectador();
        
        espectador.setIdEspectador(rs.getLong("idespectador"));
        espectador.setNombre(rs.getString("nombre"));
        espectador.setPaterno(rs.getString("paterno"));
        espectador.setMaterno(rs.getString("materno"));
        
        // Conversión de fecha de SQL a LocalDate
        if (rs.getDate("fechanacimiento") != null) {
            espectador.setFechaNacimiento(rs.getDate("fechanacimiento").toLocalDate());
        }
        
        // Conversión de género a tipo Character
        String generoStr = rs.getString("genero");
        if (generoStr != null && !generoStr.isEmpty()) {
            espectador.setGenero(generoStr.charAt(0));
        }
        
        // Conversión de hora de ingreso a LocalTime
        if (rs.getTime("horaingreso") != null) {
            espectador.setHoraIngreso(rs.getTime("horaingreso").toLocalTime());
        }

        // Conversión de hora de salida a LocalTime
        if (rs.getTime("horasalida") != null) {
            espectador.setHoraSalida(rs.getTime("horasalida").toLocalTime());
        }
        
        return espectador;
    }
}
