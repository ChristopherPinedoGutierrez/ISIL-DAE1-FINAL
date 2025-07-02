
package pe.isil.dae_01_pa4.model.beans;

public class Llave {
    private int idLlave;
    private int idKarateca1;
    private int idKarateca2;
    private int ronda;
    private Integer ganador; // Puede ser null

    public Llave() {
    }

    public Llave(int idLlave, int idKarateca1, int idKarateca2, int ronda, Integer ganador) {
        this.idLlave = idLlave;
        this.idKarateca1 = idKarateca1;
        this.idKarateca2 = idKarateca2;
        this.ronda = ronda;
        this.ganador = ganador;
    }

    public int getIdLlave() {
        return idLlave;
    }

    public void setIdLlave(int idLlave) {
        this.idLlave = idLlave;
    }

    public int getIdKarateca1() {
        return idKarateca1;
    }

    public void setIdKarateca1(int idKarateca1) {
        this.idKarateca1 = idKarateca1;
    }

    public int getIdKarateca2() {
        return idKarateca2;
    }

    public void setIdKarateca2(int idKarateca2) {
        this.idKarateca2 = idKarateca2;
    }

    public int getRonda() {
        return ronda;
    }

    public void setRonda(int ronda) {
        this.ronda = ronda;
    }

    public Integer getGanador() {
        return ganador;
    }

    public void setGanador(Integer ganador) {
        this.ganador = ganador;
    }
}

