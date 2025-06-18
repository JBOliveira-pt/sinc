package pt.upskill.projeto_sinc.models;

public enum Interest {
    ESPORTES("Esportes"),
    CINEMA("Cinema"),
    SÉRIES("Séries"),
    GAMES("Games"),
    MÚSICA("Música"),
    LEITURA("Leitura"),
    FOTOGRAFIA("Fotografia"),
    VIAGENS("Viagens"),
    COZINHA("Cozinha"),
    ANIMAIS("Animais");

    private String interest;

    Interest(String interest) {
        this.interest = interest;
    }

    public String getInterest() {
        return interest;
    }

    @Override
    public String toString() {
        return interest;}
}