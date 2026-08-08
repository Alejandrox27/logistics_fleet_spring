package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.MonthlyMaintenanceCostView;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.didiermej.logistic_fleet.repository.MaintenanceRepo;
import org.didiermej.logistic_fleet.repository.MonthlyMaintenanceCostViewRepo;
import org.didiermej.logistic_fleet.repository.VehicleRepo;
import org.didiermej.logistic_fleet.service.VehicleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VehicleServiceImpl implements VehicleService {

    private final VehicleRepo vehicleRepo;
    private final MaintenanceRepo maintenanceRepo;
    private final MonthlyMaintenanceCostViewRepo monthlyMaintenanceCostViewRepo;

    @Override
    public Vehicle save(Vehicle vehicle) {
        return vehicleRepo.save(vehicle);
    }

    @Override
    public Vehicle update(Integer id, Vehicle vehicle) {
        vehicle.setIdVehicle(id);
        return vehicleRepo.save(vehicle);
    }

    @Override
    public List<Vehicle> findAll() {
        return vehicleRepo.findAll();
    }

    @Override
    public Vehicle findById(Integer id) {
        return vehicleRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("The vehicle with id " + id + " does not exist"));
    }

    @Override
    public void delete(Integer id) {
        vehicleRepo.deleteById(id);
    }

    @Transactional
    @Override
    public void registerMaintenance(Integer vehicleId, Double cost, String description) {
        maintenanceRepo.registerMaintenance(vehicleId, cost, description);
    }

    @Transactional
    @Override
    public void finishMaintenance(Integer vehicleId) {
        maintenanceRepo.finishMaintenance(vehicleId);
    }

    @Override
    public List<MonthlyMaintenanceCostView> getMonthlyMaintenanceCost() {
        return monthlyMaintenanceCostViewRepo.findAll();
    }
}
