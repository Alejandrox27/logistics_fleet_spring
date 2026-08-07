package org.didiermej.logistic_fleet.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "vehicles")
public class Vehicle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_vehicle")
    private Integer idVehicle;

    @Column(name = "number_plate", nullable = false, length = 7)
    private String numberPlate;

    @Column(name = "brand", nullable = false, length = 50)
    private String brand;

    @Column(name = "model", nullable = false)
    private Short model;

    @Column(name = "load_capacity")
    private Integer loadCapacity;

    @Column(name = "mileage", nullable = false)
    private Integer mileage;

    @Column(name = "axles")
    private Integer axles;

    @Enumerated(EnumType.STRING)
    @Column(name = "fuel_type", columnDefinition = "fuel_type")
    private FuelType fuelType;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status", columnDefinition = "vehicle_status")
    private VehicleStatus status;
}
