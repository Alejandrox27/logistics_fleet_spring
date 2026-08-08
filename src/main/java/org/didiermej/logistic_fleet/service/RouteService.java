package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.Route;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public interface RouteService {
    Route save (Route route);
    Route update(Integer id, Route route);
    List<Route> findAll();
    Route findById (Integer id);
    void delete (Integer id);

    void createRoute(
            String origin,
            String destination,
            Integer idVehicle,
            Integer idDriver,
            LocalDate travelDate,
            Double distance
    );

    void completeRoute(
            Integer idRoute,
            Double fuelConsumed,
            Double distance
    );
}
