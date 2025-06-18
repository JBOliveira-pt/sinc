package pt.upskill.projeto_sinc.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pt.upskill.projeto_sinc.entities.Product;

@Repository
public interface ProductsRepository extends JpaRepository<Product, Long> {
    Product findProductById(long id);
}