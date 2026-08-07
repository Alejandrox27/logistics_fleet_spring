package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.DriverLicense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DriverLicenseRepo extends JpaRepository<DriverLicense, Integer> {
    // Método útil para buscar licencias de un conductor específico
    List<DriverLicense> findByDriverIdDriver(Integer idDriver);
}
