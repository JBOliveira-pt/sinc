package pt.upskill.projeto_sinc.models;

public enum EvaluationType {
    OK(1),
    GOOD(3),
    EXCELLENT(5),
    NONE(0);

    private final int coinValue;

    EvaluationType(int coinValue) {
        this.coinValue = coinValue;
    }

    public int getCoinValue() {
        return coinValue;
    }
}