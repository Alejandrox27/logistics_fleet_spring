package org.didiermej.logistic_fleet.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import org.hibernate.annotations.Immutable;

import java.time.LocalDate;

@Data
@Entity
@Immutable // Indica que es de solo lectura (no permite INSERT/UPDATE)
@Table(name = "vw_monthly_maintenance_cost")
public class MonthlyMaintenanceCostView {

    @Id
    @Column(name = "id_vehicle")
    private Integer idVehicle;

    @Column(name = "number_plate")
    private String numberPlate;

    private String brand;
    private LocalDate month;

    @Column(name = "total_cost")
    private Double totalCost;

    @Column(name = "total_maintenances")
    private Long totalMaintenances;

    @Column(name = "cost_alert")
    private String costAlert;
}