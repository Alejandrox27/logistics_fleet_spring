package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.didiermej.logistic_fleet.model.enums.FuelType;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateVehicleRequest {
    private String numberPlate;
    private String brand;
    private Short model;
    private Integer loadCapacity;
    private Integer mileage;
    private Integer axles;
    private FuelType fuelType;
}
