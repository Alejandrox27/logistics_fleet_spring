package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.repository.DriverLicenseRepo;
import org.didiermej.logistic_fleet.repository.DriverRepo;
import org.didiermej.logistic_fleet.repository.LicenseCategoryRepo;
import org.didiermej.logistic_fleet.service.DriverService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;


@Service
@RequiredArgsConstructor
public class DriverServiceImpl implements DriverService {
    private final DriverRepo driverRepo;
    private final DriverLicenseRepo driverLicenseRepo;
    private final LicenseCategoryRepo licenseCategoryRepo;

    @Override
    public Driver save(Driver driver) {
        return driverRepo.save(driver);
    }

    @Override
    public Driver update(Integer id, Driver driver) {
        driver.setIdDriver(id);
        return driverRepo.save(driver);
    }

    @Override
    public List<Driver> findAll() {
        return driverRepo.findAll();
    }

    @Override
    public Driver findById(Integer id) {
        return driverRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("driver with id " + id + " not found"));
    }

    @Override
    public void delete(Integer id) {
        driverRepo.deleteById(id);
    }

    @Override
    public List<LicenseCategory> getAllLicenseCategories() {
        return licenseCategoryRepo.findAll();
    }

    @Override
    @Transactional
    public DriverLicense addLicenseToDriver(Integer driverId, Integer categoryId,
                                            LocalDate issueDate, LocalDate expiryDate, String description)
    {
        // 1. validar que el conductor exista
        Driver driver = driverRepo.findById(driverId)
                .orElseThrow(() -> new RuntimeException("The driver with id " + driverId + " does not exist"));

        // 2. validar que lla categoria exista
        LicenseCategory category = licenseCategoryRepo.findById(categoryId)
                .orElseThrow(() -> new RuntimeException("The category with id " + categoryId + " does not exist"));


        DriverLicense driverLicense = new DriverLicense();
        driverLicense.setDriver(driver);
        driverLicense.setCategory(category);
        driverLicense.setDescription(description);
        driverLicense.setIssueDate(issueDate);
        driverLicense.setExpiryDate(expiryDate);

        return driverLicenseRepo.save(driverLicense);
    }
}
