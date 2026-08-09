package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AddLicenseDriverRequest {
    private Integer driverId;
    private Integer categoryId;
    private LocalDate issueDate;
    private LocalDate expiryDate;
    private String description;
}
