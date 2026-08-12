package org.didiermej.logistic_fleet.security;

import lombok.RequiredArgsConstructor;
import org.didiermej.logistic_fleet.model.UserInfo;
import org.didiermej.logistic_fleet.repository.UserInfoRepo;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import java.util.Collections;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService{
    private final UserInfoRepo userInfoRepo;

    @Override
    public UserDetails loadUserByUsername(@NonNull String username) throws UsernameNotFoundException {
        // Busca el usuario en la base de datos
        UserInfo userInfo = userInfoRepo.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        //Retorna el obtejo userDetails de SpringSecurity con la clave encriptada y el Rol
        return new User(
                userInfo.getUsername(),
                userInfo.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority(userInfo.getRole().name()))
        );
    }
}
