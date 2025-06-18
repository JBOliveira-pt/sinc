package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.Post;

import java.util.List;
import java.util.Optional;

@Service
public interface PostService {
    Post save(Post post);
    List<Post> findAll();
    Optional<Post> findById(Long id);
}