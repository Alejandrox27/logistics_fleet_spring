package org.didiermej.logistic_fleet.controller;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.Driver;
import org.didiermej.logistic_fleet.model.DriverLicense;
import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.didiermej.logistic_fleet.model.dto.AddLicenseDriverRequest;
import org.didiermej.logistic_fleet.model.dto.CreateDriverRequest;
import org.didiermej.logistic_fleet.model.dto.UpdateDriverRequest;
import org.didiermej.logistic_fleet.service.DriverService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/drivers")
@RequiredArgsConstructor
public class DriverController {

    private final DriverService driverService;

    @GetMapping
    public ResponseEntity<List<Driver>> getAllDrivers () {
        List<Driver> drivers = driverService.findAll();

        return ResponseEntity.ok(drivers);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Driver> getDriver(@PathVariable("id") Integer id) {
        Driver driver =driverService.findById(id);

        return ResponseEntity.ok(driver);
    }

    @GetMapping("/licenses-categories")
    public ResponseEntity<List<LicenseCategory>> getAllLicenseCategories () {
        List<LicenseCategory> licenseCategories = driverService.getAllLicenseCategories();

        return ResponseEntity.ok(licenseCategories);
    }

    @GetMapping("/licenses/{id}")
    public ResponseEntity<List<DriverLicense>> getDriverLicenses (@PathVariable("id") Integer id) {
        List<DriverLicense> licenses = driverService.getLicensesFromDriver(id);

        return ResponseEntity.ok(licenses);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDriver (@PathVariable("id") Integer id) {
        driverService.delete(id);

        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/add-license")
    public ResponseEntity<Void> addLicense(@RequestBody AddLicenseDriverRequest addLicenseDriverRequest) {
        driverService.addLicenseToDriver(addLicenseDriverRequest);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Driver> updateDriver(@PathVariable("id") Integer id, @RequestBody UpdateDriverRequest updateDriverRequest) {
        Driver updatedDriver = driverService.update(id, updateDriverRequest);

        return ResponseEntity.ok(updatedDriver);
    }

    @PostMapping
    public ResponseEntity<Driver> addDriver(@RequestBody CreateDriverRequest createDriverRequest) {
        Driver savedDriver = driverService.save(createDriverRequest);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedDriver);
    }

}
