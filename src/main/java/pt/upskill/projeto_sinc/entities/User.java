package pt.upskill.projeto_sinc.entities;

import jakarta.persistence.*;
import pt.upskill.projeto_sinc.models.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Entity
public class User {

    @Id
    @GeneratedValue
    private Long id;

    @Column(name= "about_me", length = 500)
    private String aboutMe;
    private String username;
    private String password;
    private LocalDate birthDate;
    @Enumerated(EnumType.STRING)
    private Technology technology;
    @Column(name = "interests")
    private String interests;

    //Profissionais
    private LocalDate admissionDate;
    @Enumerated(EnumType.STRING)
    private Position position;
    @Enumerated(EnumType.STRING)
    private Department department;
    @Enumerated(EnumType.STRING)
    private Role role;

    private Integer coins = 10; // SALDO INICIAL

    private String profilePicture = "https://cdn-icons-png.freepik.com/512/8608/8608769.png"; // IMAGEM PADRÃO

    public User() {
    }

    public User(SignUpModel model) {
        this.username = model.getUsername();
        this.password = model.getPassword();
        this.department = model.getDepartment();
        this.role = model.getRole();
        this.birthDate = model.getBirthDate();
        this.admissionDate = model.getAdmissionDate();
        this.position = model.getPosition();
        this.setInterests(model.getInterests());
        this.technology = model.getTechnology();
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public Integer getCoins() {
        return coins;
    }

    public Long getId() {
        return id;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public Technology getTechnology() {
        return technology;
    }

    public Role getRole() {
        return role;
    }

    public Department getDepartment() {
        return department;
    }

    public LocalDate getAdmissionDate() {
        return admissionDate;
    }

    public Position getPosition() {
        return position;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public void setTechnology(Technology technology) {
        this.technology = technology;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public void setCoins(Integer coins) {
        this.coins = coins;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public void setAdmissionDate(LocalDate admissionDate) {
        this.admissionDate = admissionDate;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public void setInterests(List<Interest> interests) {
        this.interests = interests.stream().map(Enum::name).collect(Collectors.joining(","));
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public String getInterests() {
        return interests;
    }

    public void setInterests(String interests) {
        this.interests = interests;
    }

    public List<Interest> getInterestList() {
        if (interests == null || interests.isEmpty()) {
            return new ArrayList<>();
        }
        return Arrays.stream(interests.split(","))
                .map(str -> Interest.valueOf(str))
                .collect(Collectors.toList());
    }

    public void addCoins(Integer amount){
        this.coins = Math.max(0, this.coins + amount);
    }

    public boolean removeCoins(Integer amount){
        if(this.coins >= amount){
            this.coins -= amount;
            return true;
        }
        return false;
    }
}