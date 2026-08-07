package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.Maintenance;
import org.didiermej.logistic_fleet.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MaintenanceRepo extends JpaRepository<Maintenance, Integer> {

    List<Vehicle> findByVehicleIdVehicle(Integer idVehicle);

    // Procedimiento almacenado: registrar mantenimiento
    @Procedure(procedureName = "register_maintenance")
    void registerMaintenance (
            @Param("p_id_vehicle") Integer idVehicle
    );
}
