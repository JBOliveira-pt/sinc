package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Role;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
    User findByRole(Role role);
}