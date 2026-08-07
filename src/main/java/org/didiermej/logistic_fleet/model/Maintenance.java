package org.didiermej.logistic_fleet.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "maintenances")
public class Maintenance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_maintenance")
    private Integer idMaintenance;

    @Column(name = "date", nullable = false)
    private LocalDate date;

    @Column(name = "description", length = 50)
    private String description;

    @Column(name = "maintenance_cost", nullable = false)
    private Double maintenanceCost;

    @ManyToOne
    @JoinColumn(name = "id_vehicle", nullable = false)
    private Vehicle vehicle;
}