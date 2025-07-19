package pe.isil.dae_01_pa4.business_logic;

import java.util.ArrayList;
import pe.isil.dae_01_pa4.model.beans.Karateca;
import pe.isil.dae_01_pa4.model.data_access.DA_Karateca;

public class BL_Karateca {

    DA_Karateca da_karateca = new DA_Karateca();

    // Obtener todos los karatecas
    public ArrayList<Karateca> getAll() {
        return da_karateca.getAll();
    }

    // Agregar karateca
    public boolean add(Karateca karateca) {
        return da_karateca.add(karateca);
    }

    // Obtener un karateca por su ID
    public Karateca getById(int id) {
        return da_karateca.getById(id);
    }

    // Actualizar karateca
    public boolean update(Karateca karateca) {
        return da_karateca.update(karateca);
    }

    // Eliminar karateca
    public boolean delete(int idKarateca) {
        return da_karateca.delete(idKarateca);
    }
}