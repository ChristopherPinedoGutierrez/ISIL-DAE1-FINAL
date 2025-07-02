
package pe.isil.dae_01_pa4.model.beans;

public class Academia {
    private int idLiga;
    private String nombre;
    private String ruc;

    public Academia() {
    }

    public Academia(int idLiga, String nombre, String ruc) {
        this.idLiga = idLiga;
        this.nombre = nombre;
        this.ruc = ruc;
    }

    public int getIdLiga() {
        return idLiga;
    }

    public void setIdLiga(int idLiga) {
        this.idLiga = idLiga;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
}

