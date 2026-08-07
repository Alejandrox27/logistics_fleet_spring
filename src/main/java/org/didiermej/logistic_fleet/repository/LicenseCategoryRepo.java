package org.didiermej.logistic_fleet.repository;

import org.didiermej.logistic_fleet.model.LicenseCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LicenseCategoryRepo extends JpaRepository<LicenseCategory, Integer> {
}
