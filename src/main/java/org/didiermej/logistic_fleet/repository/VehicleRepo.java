package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleRepo extends JpaRepository<Vehicle, Integer> {
}
