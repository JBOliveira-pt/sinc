package pt.upskill.projeto_sinc.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.repositories.UserRepository;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepository userRepository;

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    @Override
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
    @Override
    public void save(User user) {
        userRepository.save(user);
    }
}