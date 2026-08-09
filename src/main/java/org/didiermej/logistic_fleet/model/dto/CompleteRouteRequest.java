package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompleteRouteRequest {
    private Double fuelConsumed;
    private Double distance;
}
