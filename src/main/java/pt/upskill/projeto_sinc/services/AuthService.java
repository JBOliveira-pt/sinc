package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.LoginModel;
import pt.upskill.projeto_sinc.models.SignUpModel;

@Service
public interface AuthService {
    void registerUser(SignUpModel signUpModel);
    User validateLogin(LoginModel login);
}