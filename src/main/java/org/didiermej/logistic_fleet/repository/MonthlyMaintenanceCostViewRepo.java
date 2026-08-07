package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.MonthlyMaintenanceCostView;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MonthlyMaintenanceCostViewRepo extends JpaRepository<MonthlyMaintenanceCostView, Integer> {
}
