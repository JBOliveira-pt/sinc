package pt.upskill.projeto_sinc.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pt.upskill.projeto_sinc.entities.Product;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.repositories.ProductsRepository;
import pt.upskill.projeto_sinc.repositories.UserRepository;
import pt.upskill.projeto_sinc.services.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class StoreController {

    @Autowired ProductsRepository productsRepository;
    @Autowired UserService userService;
    @Autowired StoreService storeService;

    //MOSTRA A LOJA
    @GetMapping("/store")
    public String getStore(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        List<Product> products = productsRepository.findAll();
        model.addAttribute("products", products);
        if (userDetails != null) {
            User user = userService.findByUsername(userDetails.getUsername());
            model.addAttribute("user", user);
        }
        return "store";
    }

    //COMPRA DE PRODUTOS
    @PostMapping("/store/purchase/{productId}")
    @ResponseBody
    public ResponseEntity<?> purchaseProduct(@PathVariable Long productId, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return ResponseEntity.status(401).body("Precisas de estar autenticado para comprar produtos!");
        }
        User user = userService.findByUsername(userDetails.getUsername());
        Optional<Product> productOpt = productsRepository.findById(productId);
        if (productOpt.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Product product = productOpt.get();
        boolean success = storeService.purchaseProduct(user, product);
        if (success) {
            return ResponseEntity.ok("Compra efetuada com sucesso!");
        } else {
            return ResponseEntity.badRequest().body("Que pena! Não tens S.inCoins suficientes... tente outro produto!");
        }
    }

    //MOSTRA AS COMPRAS DO UTILIZADOR
    @GetMapping("/user/purchases")
    public String getUserPurchases(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        User user = userService.findByUsername(userDetails.getUsername());
        model.addAttribute("purchases", storeService.getUserPurchases(user));
        return "user-purchases";
    }

    //SALVA OS PRODUTOS NO CARRINHO
    @PostMapping("/store/saveCart")
    @ResponseBody
    public ResponseEntity<?> saveCart(@RequestBody List<Product> cartItems, @AuthenticationPrincipal UserDetails userDetails, HttpSession session) {
        if (userDetails == null) {
            return ResponseEntity.status(401).body("Precisas de estar autenticado para adicionar produtos ao carrinho!");
        }
        session.setAttribute("cartItems_" + userDetails.getUsername(), cartItems);
        return ResponseEntity.ok().build();
    }

    //CARREGA OS PRODUTOS DO CARRINHO
    @GetMapping("/store/loadCart")
    @ResponseBody
    public ResponseEntity<List<Product>> loadCart(@AuthenticationPrincipal UserDetails userDetails, HttpSession session) {
        if (userDetails == null) {
            return ResponseEntity.status(401).body(null);
        }
        List<Product> cartItems = (List<Product>) session.getAttribute("cartItems_" + userDetails.getUsername());
        return ResponseEntity.ok(cartItems != null ? cartItems : List.of());
    }

    //PROCESSA A COMPRA DOS PRODUTOS NO CARRINHO
    @PostMapping("/store/concluirCompras")
    @ResponseBody
    public ResponseEntity<?> concluirCompras(@RequestBody Map<String, Object> requestMap,
                                             @AuthenticationPrincipal UserDetails userDetails,
                                             HttpSession session) {
        if (userDetails == null) {
            return ResponseEntity.status(401).body("Precisas de estar autenticado para completar a compra!");
        }

        User user = userService.findByUsername(userDetails.getUsername());

        double total = ((Number) requestMap.get("total")).doubleValue();

        // Verificar se o usuário tem saldo suficiente
        if (user.getCoins() < total) {
            return ResponseEntity.badRequest().body("Que pena! Não tens S.inCoins suficientes...");
        }

        try {
            // Processar cada item no carrinho
            List<Map<String, Object>> items = (List<Map<String, Object>>) requestMap.get("items");
            for (Map<String, Object> item : items) {
                Long productId = Long.valueOf(String.valueOf(item.get("id")));
                int quantity = ((Number) item.get("quantity")).intValue();

                Optional<Product> productOpt = productsRepository.findById(productId);
                if (productOpt.isEmpty()) {
                    return ResponseEntity.badRequest().body("Produto não encontrado: " + productId);
                }

                // Registrar a compra para cada item
                storeService.purchaseProductWithQuantity(user, productOpt.get(), quantity);
            }

            // Deduzir o total da conta do usuário
            user.setCoins(user.getCoins() - (int)total);
            userService.save(user);

            // Limpar o carrinho da sessão
            session.removeAttribute("cartItems_" + userDetails.getUsername());

            return ResponseEntity.ok("Compra efetuada com sucesso!");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erro ao processar a compra: " + e.getMessage());
        }
    }

    @GetMapping("/user/profile/balance")
    @ResponseBody
    public ResponseEntity<?> getUserBalance(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return ResponseEntity.status(401).body("You must be logged in to view your balance");
        }
        User user = userService.findByUsername(userDetails.getUsername());
        return ResponseEntity.ok(Map.of("coins", user.getCoins()));
    }
}