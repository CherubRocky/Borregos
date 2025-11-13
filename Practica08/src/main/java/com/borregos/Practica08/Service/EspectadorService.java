package com.borregos.Practica08.service;

import com.borregos.Practica08.model.Espectador;
import com.borregos.Practica08.repository.EspectadorRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

/**
 * Servicio con lógica de negocio para Espectador
 */
@Service
public class EspectadorService {
    
    private final EspectadorRepository espectadorRepository;
    
    public EspectadorService(EspectadorRepository espectadorRepository) {
        this.espectadorRepository = espectadorRepository;
    }
    
    /**
     * Obtener todos los espectadores
     */
    public List<Espectador> getAllEspectadores() {
        return espectadorRepository.findAll();
    }
    
    /**
     * Buscar espectador por ID
     */
    public Optional<Espectador> getEspectadorById(Long id) {
        return espectadorRepository.findById(id);
    }
    
    /**
     * Crear un nuevo espectador con validaciones
     */
    public Espectador createEspectador(Espectador espectador) {
        // Validaciones de negocio
        validateEspectador(espectador);
        
        int result = espectadorRepository.save(espectador);
        if (result > 0) {
            return espectador;
        }
        throw new RuntimeException("No se pudo crear el espectador");
    }
    
    /**
     * Actualizar un espectador existente
     */
    public Espectador updateEspectador(Long id, Espectador espectador) {
        // Verificar que existe
        Optional<Espectador> existente = espectadorRepository.findById(id);
        if (existente.isEmpty()) {
            throw new RuntimeException("Espectador no encontrado con ID: " + id);
        }
        
        // Validaciones de negocio
        validateEspectador(espectador);
        
        int result = espectadorRepository.update(id, espectador);
        if (result > 0) {
            espectador.setIdEspectador(id);
            return espectador;
        }
        throw new RuntimeException("No se pudo actualizar el espectador");
    }
    
    /**
     * Eliminar un espectador
     */
    public void deleteEspectador(Long id) {
        Optional<Espectador> existente = espectadorRepository.findById(id);
        if (existente.isEmpty()) {
            throw new RuntimeException("Espectador no encontrado con ID: " + id);
        }
        
        int result = espectadorRepository.deleteById(id);
        if (result == 0) {
            throw new RuntimeException("No se pudo eliminar el espectador");
        }
    }
    
    /**
     * Obtener cantidad total de espectadores
     */
    public int countEspectadores() {
        return espectadorRepository.count();
    }
    
    /**
     * Validaciones de negocio para Espectador
     */
    private void validateEspectador(Espectador espectador) {
        // Validar nombre no vacío
        if (espectador.getNombre() == null || espectador.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío");
        }
        
        // Validar apellido paterno no vacío
        if (espectador.getPaterno() == null || espectador.getPaterno().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido paterno no puede estar vacío");
        }
        
        // Validar materno si se proporciona
        if (espectador.getMaterno() != null && espectador.getMaterno().trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido materno no puede ser una cadena vacía");
        }
        
        // Validar fecha de nacimiento no futura
        if (espectador.getFechaNacimiento() != null && 
            espectador.getFechaNacimiento().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("La fecha de nacimiento no puede ser futura");
        }
        
        // Validar género
        if (espectador.getGenero() != null && 
            espectador.getGenero() != 'M' && espectador.getGenero() != 'F') {
            throw new IllegalArgumentException("El género debe ser 'M' o 'F'");
        }
        
        // Validar hora de ingreso (entre 09:00 y 19:00)
        if (espectador.getHoraIngreso() != null) {
            LocalTime minIngreso = LocalTime.of(9, 0);
            LocalTime maxIngreso = LocalTime.of(19, 0);
            if (espectador.getHoraIngreso().isBefore(minIngreso) || 
                espectador.getHoraIngreso().isAfter(maxIngreso)) {
                throw new IllegalArgumentException("La hora de ingreso debe estar entre 09:00 y 19:00");
            }
        }
        
        // Validar hora de salida
        if (espectador.getHoraSalida() != null && espectador.getHoraIngreso() != null) {
            LocalTime maxSalida = LocalTime.of(21, 0);
            
            if (espectador.getHoraSalida().isBefore(espectador.getHoraIngreso())) {
                throw new IllegalArgumentException("La hora de salida debe ser posterior a la hora de ingreso");
            }
            
            if (espectador.getHoraSalida().isAfter(maxSalida)) {
                throw new IllegalArgumentException("La hora de salida no puede ser posterior a las 21:00");
            }
        }
    }
}
