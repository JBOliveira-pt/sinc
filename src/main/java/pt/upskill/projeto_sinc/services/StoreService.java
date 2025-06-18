package pt.upskill.projeto_sinc.services;

import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.Product;
import pt.upskill.projeto_sinc.entities.Purchase;
import pt.upskill.projeto_sinc.entities.User;

import java.util.List;

@Service
public interface StoreService {
    Product findProductById(long id);
    public boolean purchaseProduct(User user, Product product);
    List<Purchase> getUserPurchases(User user);
    void purchaseProductWithQuantity(User user, Product product, int quantity);
    void init();
}