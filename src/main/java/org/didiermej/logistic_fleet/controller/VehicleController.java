package org.didiermej.logistic_fleet.controller;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Maintenance;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.didiermej.logistic_fleet.model.dto.RegisterMaintenanceRequest;
import org.didiermej.logistic_fleet.service.VehicleService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/vehicles")
@RequiredArgsConstructor
public class VehicleController {
    private final VehicleService vehicleService;

    @GetMapping
    public ResponseEntity<List<Vehicle>> getAllVehicles () {
        List<Vehicle> vehicles = vehicleService.findAll();

        return ResponseEntity.ok(vehicles);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Vehicle> getVehicle(@PathVariable("id") Integer id) {
        Vehicle vehicle = vehicleService.findById(id);

        return ResponseEntity.ok(vehicle);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVehicle (@PathVariable("id") Integer id) {
        vehicleService.delete(id);

        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Vehicle> updateVehicle(@PathVariable("id") Integer id, @RequestBody Vehicle vehicle) {
        Vehicle updatedVehicle = vehicleService.update(id, vehicle);

        return ResponseEntity.ok(updatedVehicle);
    }

    @PostMapping
    public ResponseEntity<Vehicle> addVehicle(@RequestBody Vehicle vehicle) {
        Vehicle savedVehicle = vehicleService.save(vehicle);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedVehicle);
    }

    @PostMapping("/{id}/maintenances")
    public ResponseEntity<Void> registerMaintenance(
            @PathVariable("id") Integer id,
            @RequestBody RegisterMaintenanceRequest registerMaintenanceRequest) {

        vehicleService.registerMaintenance(id, registerMaintenanceRequest);

        return ResponseEntity.status(HttpStatus.CREATED).build(); // 201 Created sin cuerpo vacio
    }

}
