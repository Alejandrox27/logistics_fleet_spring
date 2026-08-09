package org.didiermej.logistic_fleet.controller;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.service.DriverService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1/drivers")
@RequiredArgsConstructor
public class DriverController {

    private final DriverService driverService;

}
