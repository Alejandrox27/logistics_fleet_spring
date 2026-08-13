package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Maintenance;
import org.didiermej.logistic_fleet.model.MonthlyMaintenanceCostView;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.didiermej.logistic_fleet.model.dto.CreateVehicleRequest;
import org.didiermej.logistic_fleet.model.dto.RegisterMaintenanceRequest;
import org.didiermej.logistic_fleet.model.dto.UpdateVehicleRequest;
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
    public Vehicle save(CreateVehicleRequest createVehicleRequest) {
        Vehicle vehicle = new Vehicle();
        vehicle.setNumberPlate(createVehicleRequest.getNumberPlate());
        vehicle.setBrand(createVehicleRequest.getBrand());
        vehicle.setModel(createVehicleRequest.getModel());
        vehicle.setLoadCapacity(createVehicleRequest.getLoadCapacity());
        vehicle.setMileage(createVehicleRequest.getMileage());
        vehicle.setAxles(createVehicleRequest.getAxles());
        vehicle.setFuelType(createVehicleRequest.getFuelType());
        return vehicleRepo.save(vehicle);
    }

    @Override
    public Vehicle update(Integer id, UpdateVehicleRequest updateVehicleRequest) {
        Vehicle vehicle = vehicleRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("The vehicle with id " + id + " does not exist"));
        vehicle.setNumberPlate(updateVehicleRequest.getNumberPlate());
        vehicle.setBrand(updateVehicleRequest.getBrand());
        vehicle.setModel(updateVehicleRequest.getModel());
        vehicle.setLoadCapacity(updateVehicleRequest.getLoadCapacity());
        vehicle.setMileage(updateVehicleRequest.getMileage());
        vehicle.setAxles(updateVehicleRequest.getAxles());
        vehicle.setFuelType(updateVehicleRequest.getFuelType());
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
    public void registerMaintenance(Integer vehicleId, RegisterMaintenanceRequest registerMaintenanceRequest) {
        maintenanceRepo.registerMaintenance(
                vehicleId,
                registerMaintenanceRequest.getCost(),
                registerMaintenanceRequest.getDescription()
        );
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
