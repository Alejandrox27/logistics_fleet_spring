package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.Driver;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DriverRepo extends JpaRepository<Driver, Integer> {
}
