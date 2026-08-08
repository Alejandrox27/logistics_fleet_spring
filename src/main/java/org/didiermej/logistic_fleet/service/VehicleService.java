package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.MonthlyMaintenanceCostView;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface VehicleService {
    Vehicle save (Vehicle vehicle);
    Vehicle update(Integer id, Vehicle vehicle);
    List<Vehicle> findAll();
    Vehicle findById (Integer id);
    void delete (Integer id);

    void registerMaintenance(Integer vehicleId, Double cost, String description);

    void finishMaintenance(Integer vehicleId);

    List<MonthlyMaintenanceCostView> getMonthlyMaintenanceCost();
}
