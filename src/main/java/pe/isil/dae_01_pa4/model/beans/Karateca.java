
package pe.isil.dae_01_pa4.model.beans;

public class Karateca {
    private int idKarateca;
    private String dni;
    private String nombreCompleto;
    private int edad;
    private double peso;
    private String sexo;
    private int rango;
    private String modalidad;
    private int idLiga;

    public Karateca() {
    }

    public Karateca(int idKarateca, String dni, String nombreCompleto, int edad, double peso,
                    String sexo, int rango, String modalidad, int idLiga) {
        this.idKarateca = idKarateca;
        this.dni = dni;
        this.nombreCompleto = nombreCompleto;
        this.edad = edad;
        this.peso = peso;
        this.sexo = sexo;
        this.rango = rango;
        this.modalidad = modalidad;
        this.idLiga = idLiga;
    }

    public int getIdKarateca() {
        return idKarateca;
    }

    public void setIdKarateca(int idKarateca) {
        this.idKarateca = idKarateca;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public int getRango() {
        return rango;
    }

    public void setRango(int rango) {
        this.rango = rango;
    }

    public String getModalidad() {
        return modalidad;
    }

    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }

    public int getIdLiga() {
        return idLiga;
    }

    public void setIdLiga(int idLiga) {
        this.idLiga = idLiga;
    }
}
