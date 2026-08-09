package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateRouteRequest {
    private String origin;       // Obligatorio
    private String destination;  // Obligatorio
    private Integer idVehicle;   // Obligatorio
    private Integer idDriver;    // Obligatorio
    private LocalDate travelDate; // Opcional
    private Double distance;      // Opcional
}