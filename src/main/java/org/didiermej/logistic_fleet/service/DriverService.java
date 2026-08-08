package org.didiermej.logistic_fleet.service;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.repository.DriverLicenseRepo;
import org.didiermej.logistic_fleet.repository.DriverRepo;
import org.didiermej.logistic_fleet.repository.LicenseCategoryRepo;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public interface DriverService {
    Driver save (Driver driver);
    Driver update(Integer id, Driver driver);
    List<Driver> findAll();
    Driver findById (Integer id);
    void delete (Integer id);

    List<LicenseCategory> getAllLicenseCategories();

    DriverLicense addLicenseToDriver(
            Integer driverId, Integer categoryId, LocalDate issueDate, LocalDate expiryDate, String description
    );
}
