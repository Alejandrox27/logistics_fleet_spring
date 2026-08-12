package org.didiermej.logistic_fleet.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.didiermej.logistic_fleet.model.enums.DriverStatus;

import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "drivers")
public class Driver {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_driver")
    private Integer idDriver;

    @Column(name = "num_identification", nullable = false)
    private Integer numIdentification;

    @Column(name = "name", nullable = false, length = 50)
    private String name;

    @Column(name = "lastname", nullable = false, length = 50)
    private String lastname;

    @Column(name = "second_lastname", length = 50)
    private String secondLastname;

    @Column(name = "contratation_date")
    private LocalDate contratationDate;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", columnDefinition = "driver_status")
    private DriverStatus status;
}
