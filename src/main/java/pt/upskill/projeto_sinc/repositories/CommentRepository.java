package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.upskill.projeto_sinc.entities.Comment;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
}