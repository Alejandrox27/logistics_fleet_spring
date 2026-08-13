package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateRouteRequest {
    private String origin;
    private String destination;
    private Double distance;
    private Double fuelConsumed;
    private LocalDate travelDate;
}
