package org.didiermej.logistic_fleet.service.impl;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.model.dto.AddLicenseDriverRequest;
import org.didiermej.logistic_fleet.model.dto.CreateDriverRequest;
import org.didiermej.logistic_fleet.model.dto.UpdateDriverRequest;
import org.didiermej.logistic_fleet.repository.DriverLicenseRepo;
import org.didiermej.logistic_fleet.repository.DriverRepo;
import org.didiermej.logistic_fleet.repository.LicenseCategoryRepo;
import org.didiermej.logistic_fleet.service.DriverService;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class DriverServiceImpl implements DriverService {
    private final DriverRepo driverRepo;
    private final DriverLicenseRepo driverLicenseRepo;
    private final LicenseCategoryRepo licenseCategoryRepo;

    @Override
    public Driver save(CreateDriverRequest createDriverRequest) {
        Driver driver = new Driver();
        driver.setNumIdentification(createDriverRequest.getNumIdentification());
        driver.setName(createDriverRequest.getName());
        driver.setLastname(createDriverRequest.getLastname());
        driver.setSecondLastname(createDriverRequest.getSecondLastname());
        driver.setContratationDate(createDriverRequest.getContratationDate());
        return driverRepo.save(driver);
    }

    @Override
    public Driver update(Integer id, UpdateDriverRequest updateDriverRequest) {
        Driver driver = driverRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("driver with id " + id + " not found"));
        driver.setNumIdentification(updateDriverRequest.getNumIdentification());
        driver.setName(updateDriverRequest.getName());
        driver.setLastname(updateDriverRequest.getLastname());
        driver.setSecondLastname(updateDriverRequest.getSecondLastname());
        driver.setContratationDate(updateDriverRequest.getContratationDate());
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
    public void addLicenseToDriver(AddLicenseDriverRequest addLicenseDriverRequest)
    {
        // 1. validar que el conductor exista
        Driver driver = driverRepo.findById(addLicenseDriverRequest.getDriverId())
                .orElseThrow(() -> new RuntimeException("The driver with id " + addLicenseDriverRequest.getDriverId() + " does not exist"));

        // 2. validar que lla categoria exista
        LicenseCategory category = licenseCategoryRepo.findById(addLicenseDriverRequest.getCategoryId())
                .orElseThrow(() -> new RuntimeException("The category with id " + addLicenseDriverRequest.getCategoryId() + " does not exist"));


        DriverLicense driverLicense = new DriverLicense();
        driverLicense.setDriver(driver);
        driverLicense.setCategory(category);
        driverLicense.setDescription(addLicenseDriverRequest.getDescription());
        driverLicense.setIssueDate(addLicenseDriverRequest.getIssueDate());
        driverLicense.setExpiryDate(addLicenseDriverRequest.getExpiryDate());

        driverLicenseRepo.save(driverLicense);
    }

    @Override
    public List<DriverLicense> getLicensesFromDriver(Integer id) {
        return driverLicenseRepo.findByDriverIdDriver(id);
    }
}
