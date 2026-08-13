package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.Maintenance;
import org.didiermej.logistic_fleet.model.MonthlyMaintenanceCostView;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.didiermej.logistic_fleet.model.dto.CreateVehicleRequest;
import org.didiermej.logistic_fleet.model.dto.RegisterMaintenanceRequest;
import org.didiermej.logistic_fleet.model.dto.UpdateVehicleRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface VehicleService {
    Vehicle save (CreateVehicleRequest createVehicleRequest);
    Vehicle update(Integer id, UpdateVehicleRequest updateVehicleRequest);
    List<Vehicle> findAll();
    Vehicle findById (Integer id);
    void delete (Integer id);

    void registerMaintenance(Integer vehicleId, RegisterMaintenanceRequest registerMaintenanceRequest);

    void finishMaintenance(Integer vehicleId);

    List<MonthlyMaintenanceCostView> getMonthlyMaintenanceCost();
}
