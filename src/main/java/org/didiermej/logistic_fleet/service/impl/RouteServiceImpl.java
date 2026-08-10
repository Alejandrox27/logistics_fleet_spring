package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Route;
import org.didiermej.logistic_fleet.model.dto.CompleteRouteRequest;
import org.didiermej.logistic_fleet.model.dto.CreateRouteRequest;
import org.didiermej.logistic_fleet.repository.RouteRepo;
import org.didiermej.logistic_fleet.service.RouteService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RouteServiceImpl implements RouteService {
    private final RouteRepo routeRepo;

    @Override
    public Route update(Integer id, Route route) {
        route.setIdRoute(id);
        return routeRepo.save(route);
    }

    @Override
    public List<Route> findAll() {
        return routeRepo.findAll();
    }

    @Override
    public Route findById(Integer id) {
        return routeRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("The route with id " + id + " does not exist"));
    }

    @Override
    public void delete(Integer id) {
        routeRepo.deleteById(id);
    }

    @Transactional
    @Override
    public void createRoute(CreateRouteRequest createRouteRequest) {
        routeRepo.createRoute(
                createRouteRequest.getOrigin(),
                createRouteRequest.getDestination(),
                createRouteRequest.getIdVehicle(),
                createRouteRequest.getIdDriver(),
                createRouteRequest.getTravelDate(),
                createRouteRequest.getDistance()
                );
    }

    @Transactional
    @Override
    public void completeRoute(Integer idRoute, CompleteRouteRequest completeRouteRequest) {
        routeRepo.completeRoute(
                idRoute,
                completeRouteRequest.getFuelConsumed(),
                completeRouteRequest.getDistance()
        );
    }
}
