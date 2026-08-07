package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VehicleRepo extends JpaRepository<Vehicle, Integer> {
}
