package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.Route;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;

@Repository
public interface RouteRepo extends JpaRepository<Route, Integer> {
    @Procedure(procedureName = "create_route")
    void createRoute (
            @Param("p_origin") String origin,
            @Param("p_destination") String destination,
            @Param("p_id_vehicle") Integer idVehicle,
            @Param("p_id_driver") Integer idDriver,
            @Param("p_travel_date") LocalDate travelDate,
            @Param("p_distance") Double distance
            );

    @Procedure(procedureName = "complete_route")
    void completeRoute(
            @Param("p_id_route") Integer idRoute,
            @Param("p_fuel_consumed") Double fuelConsumed,
            @Param("p_distance") Double distance
    );
}
