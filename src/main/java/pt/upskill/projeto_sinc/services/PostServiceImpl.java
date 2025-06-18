package pt.upskill.projeto_sinc.services;

import org.hibernate.query.spi.Limit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.Post;
import pt.upskill.projeto_sinc.repositories.PostRepository;

import java.util.List;
import java.util.Optional;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostRepository postRepository;

    @Override
    public Post save(Post post) {
        return postRepository.save(post);
    }

    @Override
    public List<Post> findAll() {
        return postRepository.findPostsByOrderByCreatedAtDesc(Pageable.ofSize(3));
    }

    @Override
    public Optional<Post> findById(Long id) {
        return postRepository.findById(id);
    }
}