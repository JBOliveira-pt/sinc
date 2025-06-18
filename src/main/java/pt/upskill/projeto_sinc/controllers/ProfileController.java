package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.services.FileStorageService;
import pt.upskill.projeto_sinc.services.UserService;

import java.io.IOException;
import java.util.Optional;


@Controller
public class ProfileController {
    @Autowired
    private UserService userService;
    @Autowired
    private FileStorageService fileStorageService;

    @GetMapping("/profile")
    public String ownProfile(Authentication authentication, Model model) {
        User user = userService.findByUsername(authentication.getName());
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/profile/{id}")
    public String userProfile(@PathVariable Long id, Authentication authentication, Model model) {
        Optional<User> requestedUser = userService.findById(id);
        User currentUser = userService.findByUsername(authentication.getName());

        if (currentUser.getId().equals(id)) {
            return "redirect:/profile";
        }

        if (requestedUser.isEmpty()) {
            return "redirect:/404";
        }

        model.addAttribute("user", requestedUser.get());
        return "profile";
    }

    @PostMapping("/profile/update")
    public String updateAboutMe(@RequestParam String aboutMe, Authentication authentication) {
        User user = userService.findByUsername(authentication.getName());
        if (user != null) {
            user.setAboutMe(aboutMe);
            userService.save(user);
        }
        return "redirect:/profile";
    }
    @GetMapping("/profile/change-picture")
    public String showChangePicturePage() {
        return "profile/change-picture";
    }

    @PostMapping("/profile/change-picture")
    public String changePicture(
            @RequestParam("profileImage") MultipartFile file,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        User currentUser = userService.findByUsername(authentication.getName());

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Selecione uma imagem");
            return "redirect:/profile/change-picture";
        }
        System.out.println("Received file: " + file.getOriginalFilename());

        try {
            // Check file type
            if (!file.getContentType().startsWith("image/")) {
                redirectAttributes.addFlashAttribute("error", "Apenas imagens são permitidas");
                return "redirect:/profile/change-picture";
            }

            String imageUrl = fileStorageService.storeFile(file);
            currentUser.setProfilePicture(imageUrl);
            userService.save(currentUser);

            redirectAttributes.addFlashAttribute("success", "Foto de perfil alterada com sucesso");
            return "redirect:/profile/" + currentUser.getId();

        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Erro ao salvar a imagem");
            return "redirect:/profile/change-picture";
        }
    }
}