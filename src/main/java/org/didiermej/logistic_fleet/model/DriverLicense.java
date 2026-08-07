package org.didiermej.logistic_fleet.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "driver_licenses")
public class DriverLicense {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_license")
    private Integer idLicense;

    @Column(name = "issue_date", nullable = false)
    private LocalDate issueDate;

    @Column(name = "expiry_date", nullable = false)
    private LocalDate expiryDate;

    @Column(name = "description", length = 100)
    private String description;

    // Relación con Categoría
    @ManyToOne
    @JoinColumn(name = "id_category", nullable = false)
    private LicenseCategory category;

    // Relación con Conductor
    @ManyToOne
    @JoinColumn(name = "id_driver", nullable = false)
    private Driver driver;
}