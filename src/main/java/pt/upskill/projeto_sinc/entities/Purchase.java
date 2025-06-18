package pt.upskill.projeto_sinc.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

import java.time.LocalDateTime;

@Entity
public class Purchase {
    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private User user;
    @ManyToOne
    private Product product;

    private LocalDateTime purchaseDate;
    private Integer amount;
    private int quantity;

    public Purchase(){

    }

    public Purchase(User user, Product product, Integer amount){
        this.user = user;
        this.product = product;
        this.amount = amount;
        this.purchaseDate = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Product getProduct() {
        return product;
    }

    public Integer getAmount() {
        return amount;
    }

    public LocalDateTime getPurchaseDate() {
        return purchaseDate;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public void setPurchaseDate(LocalDateTime purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}