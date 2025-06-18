package pt.upskill.projeto_sinc.models;

public enum Department {
    MARKETING("Marketing"),
    FINANCEIRO("Financeiro"),
    RH("Recursos Humanos"),
    TI("Tecnologia da Informação"),
    JURIDICO("Jurídico"),
    GERENCIA("Gerência"),
    DIRETORIA("Diretoria");

    private String name;

    Department(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return name;
    }
}