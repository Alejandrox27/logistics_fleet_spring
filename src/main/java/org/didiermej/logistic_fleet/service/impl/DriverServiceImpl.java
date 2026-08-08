package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.service.DriverService;

import java.time.LocalDate;
import java.util.List;

public class DriverServiceImpl implements DriverService {
    @Override
    public Driver save(Driver driver) {
        return null;
    }

    @Override
    public Driver update(Integer id, Driver driver) {
        return null;
    }

    @Override
    public List<Driver> findAll() {
        return List.of();
    }

    @Override
    public Driver findById(Integer id) {
        return null;
    }

    @Override
    public void delete(Integer id) {

    }

    @Override
    @Transactional
    public DriverLicense addLicenseToDriver(Integer driverId, Integer categoryId,
                                            LocalDate issueDate, LocalDate expiryDate, String description)
    {
        return null;
    }
}
