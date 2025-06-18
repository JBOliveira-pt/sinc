package pt.upskill.projeto_sinc.services;

import jakarta.annotation.PostConstruct;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pt.upskill.projeto_sinc.entities.Product;
import pt.upskill.projeto_sinc.entities.Purchase;
import pt.upskill.projeto_sinc.entities.User;
import pt.upskill.projeto_sinc.models.Role;
import pt.upskill.projeto_sinc.repositories.ProductsRepository;
import pt.upskill.projeto_sinc.repositories.PurchaseRepository;
import pt.upskill.projeto_sinc.repositories.UserRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class StoreServiceImpl implements StoreService {

    @Autowired
    PurchaseRepository purchaseRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ProductsRepository productsRepository;

    @Override
    public Product findProductById(long id) {
        return productsRepository.findProductById(id);
    }

    public void purchaseProductWithQuantity(User user, Product product, int quantity) {
        Purchase purchase = new Purchase();
        purchase.setUser(user);
        purchase.setProduct(product);
        purchase.setQuantity(quantity);
        purchase.setAmount(product.getPrice() * quantity);
        purchase.setPurchaseDate(LocalDateTime.now());
        purchaseRepository.save(purchase);
    }

    @PostConstruct
    public void init() {
        if (productsRepository.findAll().isEmpty()) {
            Product caneta = new Product();
            Product caneca = new Product();
            Product caderno = new Product();
            Product garrafa = new Product();
            Product pasta_laptop = new Product();
            Product mochila = new Product();
            Product moletom = new Product();
            Product dayOff = new Product();

            caneta.setName("Caneta Azul");
            caneca.setName("Caneca de Cerâmica");
            caderno.setName("Caderno de Anotações");
            garrafa.setName("Garrafa de Água 500ml");
            pasta_laptop.setName("Pasta Laptop Executiva");
            mochila.setName("Mochila Impermeável");
            moletom.setName("Moletom Unissex");
            dayOff.setName("Day Off");

            caneta.setDescription("Caneta cor azul com logo metálico NTT Data");
            caneca.setDescription("Caneca de cerâmica com logo preto NTT Data");
            caderno.setDescription("Caderno de Anotações NTT Data em diversas cores");
            garrafa.setDescription("Garrafa de 500ml cor azul em acrílico NTT Data");
            pasta_laptop.setDescription("Pasta Laptop Executiva NTT Data em couro sintético");
            mochila.setDescription("Mochila Impermeável NTT Data em poliéster");
            moletom.setDescription("Moletom Unissex NTT Data em algodão");
            dayOff.setDescription("Day Off para um dia de folga");

            caneta.setPrice(15);
            caneca.setPrice(25);
            caderno.setPrice(50);
            garrafa.setPrice(75);
            pasta_laptop.setPrice(100);
            mochila.setPrice(150);
            moletom.setPrice(200);
            dayOff.setPrice(500);

            caneta.setMarca("NTTData");
            caneca.setMarca("NTTData");
            caderno.setMarca("NTTData");
            garrafa.setMarca("NTTData");
            pasta_laptop.setMarca("NTTData");
            mochila.setMarca("NTTData");
            moletom.setMarca("NTTData");

            caneta.setModelo("025.0200");
            caneca.setModelo("020.0075");
            caderno.setModelo("025.0150");
            garrafa.setModelo("020.0550");
            pasta_laptop.setModelo("035.0650");
            mochila.setModelo("035.0855");
            moletom.setModelo("055.0775");

            caneta.setImageUrl("/images/caneta.png");
            caneca.setImageUrl("/images/caneca.png");
            caderno.setImageUrl("/images/caderno.png");
            garrafa.setImageUrl("/images/garrafa.png");
            pasta_laptop.setImageUrl("/images/pasta.png");
            mochila.setImageUrl("/images/mochila.png");
            moletom.setImageUrl("/images/moletom.png");
            dayOff.setImageUrl("/images/dayoff.png");

            productsRepository.save(caneta);
            System.out.println("Caneta salva");
            productsRepository.save(caneca);
            System.out.println("Caneca salva");
            productsRepository.save(caderno);
            System.out.println("Caderno salvo");
            productsRepository.save(garrafa);
            System.out.println("Garrafa salva");
            productsRepository.save(pasta_laptop);
            System.out.println("Pasta salva");
            productsRepository.save(mochila);
            System.out.println("Mochila salva");
            productsRepository.save(moletom);
            System.out.println("Moletom salvo");
            productsRepository.save(dayOff);
            System.out.println("DayOff salvo");
        }
    }

    @Transactional
    public boolean purchaseProduct(User user, Product product) {
        if (user.getCoins() >= product.getPrice()) {
            boolean deducted = user.removeCoins(product.getPrice());
            if (deducted) {
                userRepository.save(user);
                Purchase purchase = new Purchase(user, product, product.getPrice());
                purchaseRepository.save(purchase);
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Purchase> getUserPurchases(User user) {
        return purchaseRepository.findByUser(user);
    }
}