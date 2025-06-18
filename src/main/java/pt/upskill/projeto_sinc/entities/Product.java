package pt.upskill.projeto_sinc.entities;

import jakarta.persistence.*;
import pt.upskill.projeto_sinc.models.SignUpModel;

@Entity
public class Product {

    @Id
    @GeneratedValue
    //ATRIBUTOS
    private Long id;
    private String name;
    private String description;
    private Integer price;
    private String marca;
    private String modelo;
    private String imageUrl;

    //CONSTRUTORES
    //Vazio
    public Product() {
    }
    //Completo
    public Product(String name, String description, Integer price, String marca, String modelo, String imageUrl) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.marca = marca;
        this.modelo = modelo;
        this.imageUrl = imageUrl;
    }

    //GETS
    public Long getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public String getDescription(String s) {
        return description;
    }
    public Integer getPrice() {
        return price;
    }
    public String getDescription() {
        return description;
    }
    public String getMarca() {
        return marca;
    }
    public String getModelo() {
        return modelo;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    //SETS
    public void setId(Long id) {
        this.id = id;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setPrice(Integer price) {
        this.price = price;
    }
    public void setMarca(String marca) {
        this.marca = marca;
    }
    public void setModelo(String modelo) {
        this.modelo = modelo;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}