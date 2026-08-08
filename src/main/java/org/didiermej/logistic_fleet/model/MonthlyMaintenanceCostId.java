package org.didiermej.logistic_fleet.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MonthlyMaintenanceCostId implements Serializable {
    private Integer idVehicle;
    private LocalDate month;
}