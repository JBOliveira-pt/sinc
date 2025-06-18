package pt.upskill.projeto_sinc.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.Comment;
import pt.upskill.projeto_sinc.entities.FeedPost;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.repositories.CommentRepository;
import pt.upskill.projeto_sinc.repositories.FeedPostRepository;
import pt.upskill.projeto_sinc.repositories.UserRepository;

import java.util.Optional;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private FeedPostRepository feedPostRepository;

    @Autowired
    private UserRepository userRepository;

    public void addComment(Long feedPostId, Long userId, String content) {
        FeedPost feedPost = feedPostRepository.findById(feedPostId).orElseThrow();
        User user = userRepository.findById(userId).orElseThrow();

        if (!feedPost.getUser().getId().equals(userId)) {
            Comment comment = new Comment();
            comment.setFeedPost(feedPost);
            comment.setUser(user);
            comment.setContent(content);
            commentRepository.save(comment);
        } else {
            throw new IllegalArgumentException("The creator of the post cannot comment on their own post.");
        }
    }
    public Comment save(Comment comment) {
        return commentRepository.save(comment);
    }

    public Optional<Comment> findById(Long id){
        return commentRepository.findById(id);
    }
}