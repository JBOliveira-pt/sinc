package pt.upskill.projeto_sinc.controllers;

import io.micrometer.common.lang.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Department;
import pt.upskill.projeto_sinc.models.Interest;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.models.SignUpModel;
import pt.upskill.projeto_sinc.services.AuthService;
import pt.upskill.projeto_sinc.services.UserService;

import java.util.stream.Collectors;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;
    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String root(@AuthenticationPrincipal UserDetails userDetails){
        if(userDetails != null){
            User user = userService.findByUsername(userDetails.getUsername());
            if(user.getRole() == Role.ADMIN){
                return "redirect:/controlPanel";
            }
            return "redirect:/profile/" + user.getId();
        }
        return "redirect:/login";
    }

    @GetMapping("/login")
    public ModelAndView loginPage(@RequestParam("success") @Nullable String success) {
        ModelAndView mav = new ModelAndView("login");
        if (success != null)
            mav.addObject("success", "Registo realizado, por favor faça login.");
        return mav;
    }

    @GetMapping("/signup")
    public String showSignupForm(Model model){
        model.addAttribute("interests", Interest.values());
        model.addAttribute("departments", Department.values());
        return "signup";
    }

    @PostMapping("/signup")
    public ModelAndView signUpAction(@Validated SignUpModel signUpModel, BindingResult bindingResult) {
        ModelAndView mav = new ModelAndView("signup");
        if (bindingResult.hasErrors()) {
            System.out.println(bindingResult.getFieldErrors());
            mav.addObject("signupModel", signUpModel);
            mav.addObject("errorMap", bindingResult.getFieldErrors().stream().collect(Collectors.toMap
                    (FieldError::getField, fieldError -> fieldError.getDefaultMessage())));
            return mav;
        }
        try {
            authService.registerUser(signUpModel);
            mav.setViewName("redirect:/login?success=true");
        } catch (Exception e) {
            mav.addObject("error", e.getMessage());
        }
        mav.addObject("interests", Interest.values());
        mav.addObject("departments", Department.values());
        return mav;
    }
}