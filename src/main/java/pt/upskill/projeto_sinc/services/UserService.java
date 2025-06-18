package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;

import java.util.Optional;

@Service
public interface UserService {
    User findByUsername(String username);
    Optional<User> findById(Long id);
    void save(User user);
}