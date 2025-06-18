package pt.upskill.projeto_sinc.entities;

import jakarta.persistence.*;
import pt.upskill.projeto_sinc.models.EvaluationType;

import java.time.LocalDateTime;

@Entity
public class Comment {

    //ATRIBUTOS
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    @JoinColumn(name = "feed_post_id")
    private FeedPost feedPost;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    private String content;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP")
    private LocalDateTime createdAt;

    @Enumerated(EnumType.STRING)
    private EvaluationType evaluation = EvaluationType.NONE;
    private boolean evaluated = false;
    private boolean hasBeenReplied = false;
    //MÉTODOS
    //Data de criação
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    //GETTERS AND SETTERS

    public EvaluationType getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(EvaluationType evaluation) {
        this.evaluation = evaluation;
    }

    public boolean isEvaluated() {
        return evaluated;
    }

    public void setEvaluated(boolean evaluated) {
        this.evaluated = evaluated;
    }


    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public FeedPost getFeedPost() {
        return feedPost;
    }
    public void setFeedPost(FeedPost feedPost) {
        this.feedPost = feedPost;
    }
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public void setHasBeenReplied(boolean b) {
        this.hasBeenReplied = b;
    }
    public boolean isHasBeenReplied() {
        return hasBeenReplied;
    }
}
