package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.upskill.projeto_sinc.entities.Product;
import pt.upskill.projeto_sinc.entities.Purchase;
import pt.upskill.projeto_sinc.entities.User;

import java.util.List;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, Long> {
    List<Purchase> findByUser(User user);
    List<Purchase> findByProduct(Product product);
}