package pt.upskill.projeto_sinc.models;

public class LoginModel {

    private final String username;
    private final String password;

    public LoginModel(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public String getUsername() {
        return this.username;
    }
    public String getPassword() {
        return this.password;
    }
}