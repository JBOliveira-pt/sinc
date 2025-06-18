package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.services.UserService;

@ControllerAdvice
public class UserControllerAdvice {

    @Autowired
    private UserService userService;

    @ModelAttribute
    public void setUser(Model model, @AuthenticationPrincipal UserDetails userDetails){
        if(userDetails != null){
            User user = userService.findByUsername(userDetails.getUsername());
            model.addAttribute("authUser", user);
        }
    }
}