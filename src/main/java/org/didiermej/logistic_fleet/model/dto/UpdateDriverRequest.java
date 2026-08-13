package org.didiermej.logistic_fleet.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateDriverRequest {
    private Integer numIdentification;
    private String name;
    private String lastname;
    private String secondLastname;
    private LocalDate contratationDate;
}
