package pt.upskill.projeto_sinc.entities;


import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity

public class FeedPost {

    //ATRIBUTOS
    @Id
    @GeneratedValue
    private Long id;
    private String title;
    @Column(length = 500) private String content;
    @Lob
    private byte[] attachment;

    @Column
    private String attachmentName;

    @Column
    private String attachmentType;

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "feedPost", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> comments;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    //GETTERS AND SETTERS
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public void setAttachment(byte [] attachment) {
        this.attachment = attachment;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setAttachmentName(String originalFilename) {
        this.attachmentName = originalFilename;
    }

    public void setAttachmentType(String contentType) {
        this.attachmentType = contentType;
    }

    public String getAttachmentType() {
        return attachmentType;
    }

    public String getAttachmentName() {
        return attachmentName;
    }
}