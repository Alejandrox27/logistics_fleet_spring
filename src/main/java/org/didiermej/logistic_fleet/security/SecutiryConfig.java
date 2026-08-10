package org.didiermej.logistic_fleet.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecutiryConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // Deshabilitar CSRF (estándar para APIs REST que se prueban desde Postman / Frontend)
                .csrf(AbstractHttpConfigurer::disable)
                // Configurar permisos de acceso por tipo de método HTTP
                .authorizeHttpRequests(
                        auth -> auth
                                // Permit all GETTERS
                                .requestMatchers(HttpMethod.GET, "/v1/**").permitAll()
                                // Only ADMIN users can use POST, PUT, PATCH, DELETE
                                .requestMatchers(HttpMethod.POST, "/v1/**").hasRole("ADMIN")
                                .requestMatchers(HttpMethod.PUT, "/v1/**").hasRole("ADMIN")
                                .requestMatchers(HttpMethod.PATCH, "/v1/**").hasRole("ADMIN")
                                .requestMatchers(HttpMethod.DELETE, "/v1/**").hasRole("ADMIN")
                                // Any other request needs to be authenticated
                                .anyRequest().authenticated()
                )
                .httpBasic(Customizer.withDefaults()); // Basic AUTH (username and password)

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
