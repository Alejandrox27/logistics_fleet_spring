package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.model.dto.AddLicenseDriverRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface DriverService {
    Driver save (Driver driver);
    Driver update(Integer id, Driver driver);
    List<Driver> findAll();
    Driver findById (Integer id);
    void delete (Integer id);

    List<LicenseCategory> getAllLicenseCategories();

    void addLicenseToDriver(AddLicenseDriverRequest addLicenseDriverRequest);

    List<DriverLicense> getLicensesFromDriver (Integer id);
}
