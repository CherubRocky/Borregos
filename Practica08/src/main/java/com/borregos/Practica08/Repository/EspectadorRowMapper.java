package com.borregos.Practica08.mapper;

import com.borregos.Practica08.model.Espectador;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Mapper para convertir ResultSet de base de datos a objetos Espectador
 */
public class EspectadorRowMapper implements RowMapper<Espectador> {
    
    @Override
    public Espectador mapRow(ResultSet rs, int rowNum) throws SQLException {
        Espectador espectador = new Espectador();
        
        espectador.setIdEspectador(rs.getLong("idespectador"));
        espectador.setNombre(rs.getString("nombre"));
        espectador.setPaterno(rs.getString("paterno"));
        espectador.setMaterno(rs.getString("materno"));
        
        // Manejo de fecha
        if (rs.getDate("fechanacimiento") != null) {
            espectador.setFechaNacimiento(rs.getDate("fechanacimiento").toLocalDate());
        }
        
        // Manejo de género (char)
        String generoStr = rs.getString("genero");
        if (generoStr != null && !generoStr.isEmpty()) {
            espectador.setGenero(generoStr.charAt(0));
        }
        
        // Manejo de horas
        if (rs.getTime("horaingreso") != null) {
            espectador.setHoraIngreso(rs.getTime("horaingreso").toLocalTime());
        }
        
        if (rs.getTime("horasalida") != null) {
            espectador.setHoraSalida(rs.getTime("horasalida").toLocalTime());
        }
        
        return espectador;
    }
}
