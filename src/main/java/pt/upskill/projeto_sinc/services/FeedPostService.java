package pt.upskill.projeto_sinc.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.FeedPost;

import pt.upskill.projeto_sinc.repositories.FeedPostRepository;

import java.util.List;
import java.util.Optional;

@Service
public class FeedPostService {
    @Autowired
    private FeedPostRepository feedPostRepository;

    public FeedPost saveFeedPost(FeedPost feedPost) {
        return feedPostRepository.save(feedPost);
    }


    public List<FeedPost> findAllFeedPost() {
        return feedPostRepository.findAllByOrderByCreatedAtDesc();
    }

    public Optional<FeedPost> findById(Long id) {
        return feedPostRepository.findById(id);
    }

}