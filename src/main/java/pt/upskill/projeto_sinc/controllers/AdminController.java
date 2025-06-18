package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pt.upskill.projeto_sinc.entities.Post;
import pt.upskill.projeto_sinc.services.PostService;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Controller
public class AdminController {

    @Autowired
    private PostService postService;

    @GetMapping("/controlPanel")
    public String controlPanel(Model model) {
        model.addAttribute("posts", postService.findAll());
        return "controlPanel";
    }

    @PostMapping(value = "/posts", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAuthority('ADMIN')")
    public String createPost(@RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam(value = "attachment", required = false) MultipartFile attachment,
                             RedirectAttributes redirectAttributes, Authentication authentication) throws IOException {
        try {
            if (authentication == null || !authentication.isAuthenticated()) {
                throw new AccessDeniedException("User not authenticated");
            }

            Post post = new Post();
            post.setTitle(title);
            post.setDescription(description);

            if (attachment != null && !attachment.isEmpty()) {
                String contentType = attachment.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new IllegalArgumentException("Only image files are allowed");
                }

                post.setAttachment(attachment.getBytes());
                post.setAttachmentName(attachment.getOriginalFilename());
                post.setAttachmentType(contentType);
            }

            postService.save(post);
            redirectAttributes.addFlashAttribute("success", "Post criado com sucesso!");
            return "redirect:/controlPanel";

        } catch (AccessDeniedException e) {
            redirectAttributes.addFlashAttribute("error", "Acesso negado");
            return "redirect:/login";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erro ao criar post: " + e.getMessage());
            return "redirect:/controlPanel";
        }
    }

    @GetMapping("/posts/{id}/attachment")
    @ResponseBody
    public ResponseEntity<byte[]> getAttachment(@PathVariable Long id) {
        Post post = postService.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(post.getAttachmentType()))
                .header("Content-Disposition", "inline; filename=\"" + post.getAttachmentName() + "\"")
                .cacheControl(CacheControl.maxAge(1, TimeUnit.HOURS))
                .body(post.getAttachment());
    }
}