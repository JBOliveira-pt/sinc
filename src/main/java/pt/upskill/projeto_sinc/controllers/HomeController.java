package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.services.FeedPostService;
import pt.upskill.projeto_sinc.services.PostService;
import pt.upskill.projeto_sinc.services.UserService;

@Controller
public class HomeController {

    @Autowired
    PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    FeedPostService feedPostService;

    @GetMapping("/home")
    public String homePage( Model model, Authentication authentication) {

        model.addAttribute("posts", postService.findAll());
        model.addAttribute("feedposts", feedPostService.findAllFeedPost());
        model.addAttribute("user", userService.findByUsername(authentication.getName()));
        return "home";

    }
}