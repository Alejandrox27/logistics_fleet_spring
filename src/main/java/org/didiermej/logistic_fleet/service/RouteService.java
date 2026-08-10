package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.Route;
import org.didiermej.logistic_fleet.model.dto.CompleteRouteRequest;
import org.didiermej.logistic_fleet.model.dto.CreateRouteRequest;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public interface RouteService {
    Route update(Integer id, Route route);
    List<Route> findAll();
    Route findById (Integer id);
    void delete (Integer id);

    void createRoute(CreateRouteRequest createRouteRequest);

    void completeRoute(
            Integer idRoute,
            CompleteRouteRequest completeRouteRequest
    );
}
