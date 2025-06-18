package pt.upskill.projeto_sinc.models;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.*;

import java.time.LocalDate;
import java.util.List;

public class SignUpModel {

    //ATRIBUTOS
    //Pessoais
    @NotBlank(message = "Username is required") private String username;
    @NotBlank @Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$", message = "Password must be at least 8 characters long and contain at least one letter and one number.")
    private String password;

    @Past @NotNull(message = "Birth date is required and must be in the Past.")
    private LocalDate birthDate;

    private List<Interest> interests;
    @Enumerated(EnumType.STRING) private Technology technology;

    //Profissionais
    @Enumerated(EnumType.STRING) private Position position;
    @Enumerated(EnumType.STRING) private Role role;
    @Enumerated(EnumType.STRING) private Department department;

    @Past @NotNull(message = "Admission Date date is required and must be in the Past")
    private LocalDate admissionDate; //ACRESCENTADA A DATA DE ADMISSÃO (VER TELA DE SIGNUP)

    //GETS
    public String getUsername() {
        return username;
    }
    public String getPassword() {
        return password;
    }
    public Role getRole() {
        return role;
    }
    public Department getDepartment() {
        return department;
    }
    public LocalDate getBirthDate() {
        return birthDate;
    }
    public List<Interest> getInterests() {
        return interests;
    }
    public Technology getTechnology() {
        return technology;
    }
    public Position getPosition() {
        return position;
    }
    public LocalDate getAdmissionDate() {
        return admissionDate;
    }

    //SETS
    public void setPassword(String password) {
        this.password = password;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public void setRole(Role role) {
        this.role = role;
    }
    public void setDepartment(Department department) {
        this.department = department;
    }
    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }
    public void setInterests(List<Interest> interests) {
        this.interests = interests;
    }
    public void setTechnologies(Technology technology) {
        this.technology = technology;
    }
    public void setPosition(Position position) {
        this.position = position;
    }
    public void setAdmissionDate(LocalDate admissionDate) {
        this.admissionDate = admissionDate;
    }
}