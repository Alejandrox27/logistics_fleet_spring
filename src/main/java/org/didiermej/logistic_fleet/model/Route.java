package org.didiermej.logistic_fleet.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "routes")
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_route")
    private Integer idRoute;

    @Column(name = "origin", nullable = false, length = 50)
    private String origin;

    @Column(name = "destination", nullable = false, length = 50)
    private String destination;

    @Column(name = "distance")
    private Double distance;

    @Column(name = "fuel_consumed")
    private Double fuelConsumed;

    @Column(name = "travel_date", nullable = false)
    private LocalDate travelDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", columnDefinition = "route_status")
    private RouteStatus status;

    @ManyToOne
    @JoinColumn(name = "id_vehicle", nullable = false)
    private Vehicle vehicle;

    @ManyToOne
    @JoinColumn(name = "id_driver", nullable = false)
    private Driver driver;
}