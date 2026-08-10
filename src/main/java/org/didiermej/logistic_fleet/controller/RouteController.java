package org.didiermej.logistic_fleet.controller;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Route;
import org.didiermej.logistic_fleet.service.RouteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/routes")
@RequiredArgsConstructor
public class RouteController {

    private final RouteService routeService;

    @GetMapping
    public ResponseEntity<List<Route>> getAllRoutes() {
        List<Route> routes = routeService.findAll();
        return ResponseEntity.ok(routes);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Route> getRoute(@PathVariable("id") Integer id) {
        Route route = routeService.findById(id);
        return ResponseEntity.ok(route);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Route> updateRoute(@PathVariable("id") Integer id, @RequestBody Route route) {
        Route updatedRoute = routeService.update(id, route);
        return ResponseEntity.ok(updatedRoute);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRoute(@PathVariable("id") Integer id) {
        routeService.delete(id);
        return ResponseEntity.noContent().build();
    }

    
}

