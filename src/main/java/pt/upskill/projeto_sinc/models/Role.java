package pt.upskill.projeto_sinc.models;

public enum Role {
    JUNIOR("Júnior"),
    PLENO("Pleno"),
    SENIOR("Sénior"),
    ADMIN("Admin");

    private String role;

    Role(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    @Override
    public String toString() {
        return role;}
}