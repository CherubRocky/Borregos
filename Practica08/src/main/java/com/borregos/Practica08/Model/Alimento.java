package com.borregos.Practica08.Model;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Modelo para la tabla Alimento.
 * En la BD el precio es MONEY; aquí se coambio por BigDecimal.
 */
public class Alimento {

    /** PK de Alimento. */
    private Long idAlimento;

    /** Nombre del alimento. */
    private String nombre;

    /** Caducidad; puede ser null si perecedero = false. */
    private LocalDate fechaCaducidad;

    /** Indica si el alimento es perecedero. */
    private Boolean perecedero;

    /** Precio sin IVA (equivale a MONEY en BD). */
    private BigDecimal precioSinIVA;

    /**
     * @return id del alimento
     */
    public Long getIdAlimento() { return idAlimento; }

    /**
     * @param idAlimento id a establecer
     */
    public void setIdAlimento(Long idAlimento) { this.idAlimento = idAlimento; }

    /**
     * @return nombre del alimento
     */
    public String getNombre() { return nombre; }

    /**
     * @param nombre nombre a establecer
     */
    public void setNombre(String nombre) { this.nombre = nombre; }

    /**
     * @return fecha de caducidad (puede ser null)
     */
    public LocalDate getFechaCaducidad() { return fechaCaducidad; }

    /**
     * @param fechaCaducidad fecha de caducidad
     */
    public void setFechaCaducidad(LocalDate fechaCaducidad) { this.fechaCaducidad = fechaCaducidad; }

    /**
     * @return true si es perecedero
     */
    public Boolean getPerecedero() { return perecedero; }

    /**
     * @param perecedero indicador de perecederidad
     */
    public void setPerecedero(Boolean perecedero) { this.perecedero = perecedero; }

    /**
     * @return precio sin IVA
     */
    public BigDecimal getPrecioSinIVA() { return precioSinIVA; }

    /**
     * @param precioSinIVA precio sin IVA
     */
    public void setPrecioSinIVA(BigDecimal precioSinIVA) { this.precioSinIVA = precioSinIVA; }
}
