package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import pt.upskill.projeto_sinc.entities.FeedPost;

import java.util.List;

public interface FeedPostRepository extends JpaRepository<FeedPost, Long> {
    FeedPost findById(long id);
    List<FeedPost> findAllByOrderByCreatedAtDesc();
}