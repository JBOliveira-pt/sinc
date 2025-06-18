package pt.upskill.projeto_sinc.services;


import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.LoginModel;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.models.SignUpModel;
import pt.upskill.projeto_sinc.repositories.UserRepository;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    UserRepository userRepository;
    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @PostConstruct
    public void init(){
        if (userRepository.findByRole(Role.ADMIN) == null) {
            User admin = new User();
            admin.setUsername("Admin");
            admin.setPassword(passwordEncoder.encode("AD123min456"));
            admin.setRole(Role.ADMIN);
            userRepository.save(admin);
        }
    }
    @Override
    public void registerUser(SignUpModel signUpModel) {
        if(userRepository.findByUsername(signUpModel.getUsername()) != null) {
            throw new RuntimeException("User already exists!");
        }
        User user = new User(signUpModel);
        user.setPassword(passwordEncoder.encode(signUpModel.getPassword()));
        userRepository.save(user);
    }

    //Validação de Login
    @Override
    public User validateLogin(LoginModel login) {
        User user = userRepository.findByUsername(login.getUsername());
        if (user == null || user.getId() == null) {
            return null;
        }
        if (passwordEncoder.matches(login.getPassword(), user.getPassword())) {
            return user;
        }
        return null;
    }
}