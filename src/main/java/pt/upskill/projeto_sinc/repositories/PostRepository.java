package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import pt.upskill.projeto_sinc.entities.Post;

import java.util.List;

public interface PostRepository extends JpaRepository<Post, Long> {
    Post findById(long id);
    List<Post> findPostsByOrderByCreatedAtDesc(Pageable pageable);
}