package pt.upskill.projeto_sinc;

import jakarta.servlet.DispatcherType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import pt.upskill.projeto_sinc.services.CustomAuthenticationSuccessHandler;

@Configuration
public class SecurityWebConfig {

    @Autowired
    UserAuthenticationProvider userAuthenticationProvider;

    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity httpSecurity, CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler) throws Exception {
        httpSecurity.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> {
                    // RECURSOS PÚBLICOS
                    auth.requestMatchers(
                            "/login", "/signup", "/password", "/", "/favicon.ico", "/error/**", "/404", "/403", "/500", "/images/**",
                            "/styles/**", "/scripts/**", "/uploads/**", "/feedposts").permitAll();
                    // FORWARD DISPATCHER
                    auth.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll();
                    // REQUESTS POST & GET
                    auth.requestMatchers(HttpMethod.POST, "/posts/**").hasAuthority("ADMIN");
                    auth.requestMatchers(HttpMethod.POST, "/profile/change-picture").authenticated();
                    auth.requestMatchers(HttpMethod.POST, "/feedposts/add-comment").authenticated();
                    auth.requestMatchers(HttpMethod.POST, "/feedposts/evaluate-comment").authenticated();
                    auth.requestMatchers(HttpMethod.GET, "/posts/**").authenticated();
                    auth.requestMatchers(HttpMethod.GET, "/profile/change-picture").authenticated();
                    // ADMIN
                    auth.requestMatchers("/admin/**", "/controlPanel").hasAuthority("ADMIN");
                    // USERS LOGADOS (REDIRECIONAMENTOS E PERMISSÕES)
                    auth.requestMatchers("/profile/**", "/profile", "/home", "/store/**", "/colaboradores","/feedposts/**").authenticated();}).formLogin(loginConfig -> {
                    loginConfig.loginPage("/login");
                    loginConfig.loginProcessingUrl("/login");
                    loginConfig.failureUrl("/login?error=true");
                    loginConfig.successHandler(customAuthenticationSuccessHandler);
                })
                .logout(logoutConfig -> {
                    logoutConfig.logoutUrl("/logout");
                    logoutConfig.logoutSuccessUrl("/login");
                })
                .authenticationProvider(userAuthenticationProvider);
        return httpSecurity.build();
    }
}