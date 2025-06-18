package pt.upskill.projeto_sinc.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.server.ResponseStatusException;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Interest;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.repositories.UserRepository;
import pt.upskill.projeto_sinc.services.MatchService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class ColaboradoresController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MatchService matchService;

    @GetMapping("/colaboradores")
    public String showColaboradores(Model model, Authentication authentication) {
        if (authentication == null) {
            return "redirect:/login";
        }

        String username = authentication.getName();
        User currentUser = userRepository.findByUsername(username);
        if (currentUser == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }

        List<User> allUsers = userRepository.findAll().stream()
                .filter(user -> !user.getId().equals(currentUser.getId()))
                .filter(user -> user.getRole() != Role.ADMIN)
                .collect(Collectors.toList());

        System.out.println("Total users found: " + allUsers.size());

        Map<Long, Integer> matchPercentages = new HashMap<>();
        Map<Long, List<Interest>> commonInterests = new HashMap<>();

        for (User user : allUsers) {
            matchPercentages.put(user.getId(), matchService.calculateMatchPercentage(currentUser, user));
            commonInterests.put(user.getId(), matchService.getCommonInterests(currentUser, user));
        }

        allUsers.sort((u1, u2) -> {
            int percentageCompare = Integer.compare(
                    matchPercentages.getOrDefault(u2.getId(), 0),
                    matchPercentages.getOrDefault(u1.getId(), 0)
            );

            if (percentageCompare == 0) {
                return u1.getUsername().compareToIgnoreCase(u2.getUsername());
            }

            return percentageCompare;
        });

        model.addAttribute("users", allUsers);
        model.addAttribute("matchPercentages", matchPercentages);
        model.addAttribute("commonInterests", commonInterests);
        model.addAttribute("currentUserInterests", currentUser.getInterestList());

        return "colaboradores";
    }
}