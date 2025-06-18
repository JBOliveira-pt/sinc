package pt.upskill.projeto_sinc.entities;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "posts")
public class Post {
    @Id
    @GeneratedValue
    private Long id;

    private String title;
    private String description;

    @Lob
    private byte[] attachment;
    private String attachmentType;
    private String attachmentName;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP NULL")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate(){
        createdAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public String getTitle() {
        return title;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public byte[] getAttachment() {
        return attachment;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public String getAttachmentType() {
        return attachmentType;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public void setAttachmentType(String attachmentType) {
        this.attachmentType = attachmentType;
    }

    public void setAttachment(byte[] attachment) {this.attachment = attachment;}
    }