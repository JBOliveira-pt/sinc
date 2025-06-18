package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Interest;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MatchServiceImpl implements MatchService{

    @Override
    public int calculateMatchPercentage(User currentUser, User user) {
        List<Interest> interests1 = currentUser.getInterestList();
        List<Interest> interests2 = user.getInterestList();

        if(interests1.isEmpty() || interests2.isEmpty()){
            return 0;
        }

        long commonInterests = getCommonInterests(currentUser, user).size();
        int totalInterests = interests1.size();

        return (int) ((commonInterests * 100) / totalInterests);
    }

    @Override
    public List<Interest> getCommonInterests(User user1, User user2) {
        return user1.getInterestList().stream().filter(user2.getInterestList()::contains).collect(Collectors.toList());
    }
}