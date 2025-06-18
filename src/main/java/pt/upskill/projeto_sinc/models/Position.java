package pt.upskill.projeto_sinc.models;

public enum Position {
    VENDEDOR("Vendedor"),
    CONTABILISTA("Contabilista"),
    PSICOLOGO("Psicólogo"),
    PROGRAMADOR("Programador"),
    ADVOGADO("Advogado"),
    GERENTE("Gerente"),
    DIRETOR("Diretor"),
    ANALISTA("Analista"),
    ARQUITETO_SOFTWARE("Arquiteto de Software"),
    ANALISTA_MARKETING("Analista de Marketing"),
    GERENTE_MARKETING("Gerente de Marketing"),
    SOCIAL_MEDIA("Social Media"),
    ANALISTA_FINANCEIRO("Analista Financeiro"),
    CONTROLLER("Controller"),
    RECRUTADOR("Recrutador"),
    GERENTE_RH("Gerente de RH"),
    ASSISTENTE_JURIDICO("Assistente Jurídico"),
    GERENTE_PROJETO("Gerente de Projetos"),
    GERENTE_PRODUTO("Gerente de Produto"),
    DIRETOR_EXECUTIVO("Diretor Executivo");

    private String position;

    Position(String position) {
        this.position = position;
    }

    public String getPosition() {
        return position;
    }

    @Override
    public String toString() {
        return position;
    }
}