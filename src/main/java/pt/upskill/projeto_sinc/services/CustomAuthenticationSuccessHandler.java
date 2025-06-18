package pt.upskill.projeto_sinc.services;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Role;

import java.io.IOException;

@Component
public class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
    private final UserService userService;

    public CustomAuthenticationSuccessHandler(UserService userService) {
        this.userService = userService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
       User user = userService.findByUsername(authentication.getName());
       if (user != null) {
           if (user.getRole() == Role.ADMIN){
               response.sendRedirect("/controlPanel");
           } else {
               response.sendRedirect("/profile");
           }
       } else {
           response.sendRedirect("login?error");
       }
    }
}