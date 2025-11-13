package com.borregos.Practica08.model;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Entidad Espectador
 * Representa la tabla Espectador en la base de datos
 */
public class Espectador {
    
    private Long idEspectador;
    private String nombre;
    private String paterno;
    private String materno;
    private LocalDate fechaNacimiento;
    private Character genero;
    private LocalTime horaIngreso;
    private LocalTime horaSalida;
    
    // Constructor vacío
    public Espectador() {
    }
    
    // Constructor completo
    public Espectador(Long idEspectador, String nombre, String paterno, String materno, 
                      LocalDate fechaNacimiento, Character genero, LocalTime horaIngreso, 
                      LocalTime horaSalida) {
        this.idEspectador = idEspectador;
        this.nombre = nombre;
        this.paterno = paterno;
        this.materno = materno;
        this.fechaNacimiento = fechaNacimiento;
        this.genero = genero;
        this.horaIngreso = horaIngreso;
        this.horaSalida = horaSalida;
    }
    
    // Getters y Setters
    public Long getIdEspectador() {
        return idEspectador;
    }
    
    public void setIdEspectador(Long idEspectador) {
        this.idEspectador = idEspectador;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getPaterno() {
        return paterno;
    }
    
    public void setPaterno(String paterno) {
        this.paterno = paterno;
    }
    
    public String getMaterno() {
        return materno;
    }
    
    public void setMaterno(String materno) {
        this.materno = materno;
    }
    
    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }
    
    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }
    
    public Character getGenero() {
        return genero;
    }
    
    public void setGenero(Character genero) {
        this.genero = genero;
    }
    
    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }
    
    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }
    
    public LocalTime getHoraSalida() {
        return horaSalida;
    }
    
    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }
    
    @Override
    public String toString() {
        return "Espectador{" +
                "idEspectador=" + idEspectador +
                ", nombre='" + nombre + '\'' +
                ", paterno='" + paterno + '\'' +
                ", materno='" + materno + '\'' +
                ", fechaNacimiento=" + fechaNacimiento +
                ", genero=" + genero +
                ", horaIngreso=" + horaIngreso +
                ", horaSalida=" + horaSalida +
                '}';
    }
}
