package org.didiermej.logistic_fleet.service;

import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.model.dto.AddLicenseDriverRequest;
import org.didiermej.logistic_fleet.model.dto.CreateDriverRequest;
import org.didiermej.logistic_fleet.model.dto.UpdateDriverRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface DriverService {
    Driver save (CreateDriverRequest createDriverRequest);
    Driver update(Integer id, UpdateDriverRequest updateDriverRequest);
    List<Driver> findAll();
    Driver findById (Integer id);
    void delete (Integer id);

    List<LicenseCategory> getAllLicenseCategories();

    void addLicenseToDriver(AddLicenseDriverRequest addLicenseDriverRequest);

    List<DriverLicense> getLicensesFromDriver (Integer id);
}
