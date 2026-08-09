package org.didiermej.logistic_fleet.exception;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // 1. Captura las excepciones de Triggers / SQL de PostgreSQL (RAISE EXCEPTION)
    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, Object>> handleDataIntegrityViolation(DataIntegrityViolationException ex) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", LocalDateTime.now());
        body.put("status", HttpStatus.BAD_REQUEST.value());
        body.put("error", "Error de Validación en Base de Datos / Trigger");

        // Obtiene el mensaje exacto del RAISE EXCEPTION lanzado por PostgreSQL
        String rootMessage = (ex.getRootCause() != null) ? ex.getRootCause().getMessage() : ex.getMessage();
        body.put("message", rootMessage);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(body);
    }

    // 2. Captura tus RuntimeException lanzadas en los Services (ej. "Vehicle not found")
    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, Object>> handleRuntimeException(RuntimeException ex) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", LocalDateTime.now());
        body.put("status", HttpStatus.NOT_FOUND.value());
        body.put("error", "Recurso no encontrado o Error de Lógica");
        body.put("message", ex.getMessage());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(body);
    }

    // 3. Captura cualquier otro error imprevisto (500 Internal Server Error)
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> handleGenericException(Exception ex) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", LocalDateTime.now());
        body.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
        body.put("error", "Error Interno del Servidor");
        body.put("message", ex.getMessage());

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
    }
}