package pt.upskill.projeto_sinc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.LoginModel;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.services.AuthService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Component
public class UserAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    AuthService authService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getPrincipal().toString();
        String password = authentication.getCredentials().toString();
        LoginModel loginModel = new LoginModel(username, password);
        User user = authService.validateLogin(loginModel);

        if(user != null){
            List<GrantedAuthority> roleList = new ArrayList<>();
            if (user.getRole() == Role.ADMIN){
                roleList.add(new SimpleGrantedAuthority("ADMIN"));
            } else {
                roleList.add(new SimpleGrantedAuthority(user.getRole().toString()));
            }

            UserDetails userDetails = org.springframework.security.core.userdetails.User.withUsername(username).password(password).authorities(roleList).build();
            return new UsernamePasswordAuthenticationToken(userDetails, password, roleList);
        }
        return null;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}