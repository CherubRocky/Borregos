package com.borregos.Practica08.Model;

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
    
    // Constructor Espectador
    public Espectador() {
    }
    
      /**
     * Constructor completo que inicializa todos los atributos de la clase.
     *
     * @param idEspectador     Identificador único del espectador.
     * @param nombre           Nombre del espectador.
     * @param paterno          Apellido paterno.
     * @param materno          Apellido materno.
     * @param fechaNacimiento  Fecha de nacimiento.
     * @param genero           Género del espectador (por ejemplo, 'M' o 'F').
     * @param horaIngreso      Hora de ingreso al evento.
     * @param horaSalida       Hora de salida del evento.
     */
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
    
    /** @return el identificador único del espectador. */
    public Long getIdEspectador() {
        return idEspectador;
    }

    /** @param idEspectador el identificador único a establecer. */
    public void setIdEspectador(Long idEspectador) {
        this.idEspectador = idEspectador;
    }

    /** @return el nombre del espectador. */
    public String getNombre() {
        return nombre;
    }

     /** @param nombre el nombre del espectador a establecer. */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

     /** @return el apellido paterno del espectador. */
    public String getPaterno() {
        return paterno;
    }

     /** @param paterno el apellido paterno a establecer. */
    public void setPaterno(String paterno) {
        this.paterno = paterno;
    }

     /** @return el apellido materno del espectador. */
    public String getMaterno() {
        return materno;
    }

    /** @param materno el apellido materno a establecer. */
    public void setMaterno(String materno) {
        this.materno = materno;
    }

    /** @return la fecha de nacimiento del espectador. */
    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    /** @param fechaNacimiento la fecha de nacimiento a establecer. */
    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    /** @return el género del espectador. */
    public Character getGenero() {
        return genero;
    }

    /** @param genero el género del espectador ('M', 'F', u otro). */
    public void setGenero(Character genero) {
        this.genero = genero;
    }

    /** @return la hora en la que el espectador ingresó al evento. */
    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }

    /** @param horaIngreso la hora de ingreso a establecer. */
    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    /** @return la hora en la que el espectador salió del evento. */
    public LocalTime getHoraSalida() {
        return horaSalida;
    }

    /** @param horaSalida la hora de salida a establecer. */
    public void setHoraSalida(LocalTime horaSalida) {
        this.horaSalida = horaSalida;
    }

    /**
     * Devuelve una representación en cadena del espectador.
     *
     * @return una cadena con los valores de todos los atributos.
     */
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
