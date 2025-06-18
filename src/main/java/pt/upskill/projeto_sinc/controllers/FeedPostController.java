package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import pt.upskill.projeto_sinc.entities.Comment;
import pt.upskill.projeto_sinc.entities.FeedPost;
import pt.upskill.projeto_sinc.models.EvaluationType;
import pt.upskill.projeto_sinc.services.CommentService;
import pt.upskill.projeto_sinc.services.FeedPostService;
import pt.upskill.projeto_sinc.services.UserService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

@Controller
public class FeedPostController {
    @Autowired
    private FeedPostService feedPostService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private UserService userService;

    @GetMapping("/feedposts/new")
    public String showCreateFeedPostForm() {

        return "create-feedpost";
    }

    @PostMapping("/feedposts")
    public String createFeedPost(
            @RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam(value = "attachment", required = false) MultipartFile file,
            Authentication authentication
    ) throws IOException {

        FeedPost feedPost = new FeedPost();
        feedPost.setTitle(title);
        feedPost.setContent(content);
        feedPost.setCreatedAt(LocalDateTime.now());
        feedPost.setUser(userService.findByUsername(authentication.getName()));

        if (file != null && !file.isEmpty()) {
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new IllegalArgumentException("Only image files are allowed");
            }

            feedPost.setAttachment(file.getBytes());
            feedPost.setAttachmentName(file.getOriginalFilename());
            feedPost.setAttachmentType(contentType);
        }

        feedPostService.saveFeedPost(feedPost);
        return "redirect:/home";
    }

    @GetMapping("/feedposts/{id}/attachment")
    @ResponseBody
    public ResponseEntity<byte[]> getAttachment(@PathVariable Long id) {
        FeedPost feedPost = feedPostService.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        if (feedPost.getAttachment() == null || feedPost.getAttachment().length == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "No attachment found");
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(feedPost.getAttachmentType()))
                .header("Content-Disposition", "inline; filename=\"" + feedPost.getAttachmentName() + "\"")
                .cacheControl(CacheControl.maxAge(1, TimeUnit.HOURS))
                .body(feedPost.getAttachment());
    }

    @PostMapping("/feedposts/add-comment")
    public String addComment(
            @RequestParam("feedPostId") Long feedPostId,
            @RequestParam("content") String content,
            @RequestParam(value = "parentCommentId", required = false) Long parentCommentId,
            Authentication authentication) {

        FeedPost feedPost = feedPostService.findById(feedPostId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid feed post ID"));

        Comment comment = new Comment();
        comment.setContent(content);
        comment.setFeedPost(feedPost);
        comment.setUser(userService.findByUsername(authentication.getName()));
        comment.setCreatedAt(LocalDateTime.now());

        if (parentCommentId != null) {
            Comment parentComment = commentService.findById(parentCommentId)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid parent comment ID"));

            parentComment.setHasBeenReplied(true);
            commentService.save(parentComment);
        }

        commentService.save(comment);
        return "redirect:/home";
    }

    @PostMapping("/feedposts/evaluate-comment")
    public String evaluateComment(
            @RequestParam("commentId") Long commentId,
            @RequestParam("evaluation") String evaluationString,
            Authentication authentication) {

        Comment comment = commentService.findById(commentId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid comment ID"));

        if (!comment.getFeedPost().getUser().getUsername().equals(authentication.getName())) {
            return "redirect:/home";
        }

        EvaluationType newEvaluation = EvaluationType.valueOf(evaluationString);
        EvaluationType previousEvaluation = comment.getEvaluation();
        comment.setEvaluation(newEvaluation);
        comment.setEvaluated(true);
        commentService.save(comment);

        if (previousEvaluation != newEvaluation) {
            var commentOwner = comment.getUser();
            if (previousEvaluation != null){
                commentOwner.addCoins(-previousEvaluation.getCoinValue());
            }
            commentOwner.addCoins(newEvaluation.getCoinValue());
            userService.save(commentOwner);
        }
        return "redirect:/home";
    }
}