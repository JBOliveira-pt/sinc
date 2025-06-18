package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Interest;

import java.util.List;

@Service
public interface MatchService {
    int calculateMatchPercentage(User currentUser, User user);
    List<Interest> getCommonInterests(User user1, User user2);
}