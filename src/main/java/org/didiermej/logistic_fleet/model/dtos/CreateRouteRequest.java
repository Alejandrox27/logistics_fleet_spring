package org.didiermej.logistic_fleet.model.dtos;

import lombok.Data;

import java.time.LocalDate;

@Data
public class CreateRouteRequest {
    private String origin;       // Obligatorio
    private String destination;  // Obligatorio
    private Integer idVehicle;   // Obligatorio
    private Integer idDriver;    // Obligatorio
    private LocalDate travelDate; // Opcional
    private Double distance;      // Opcional
}