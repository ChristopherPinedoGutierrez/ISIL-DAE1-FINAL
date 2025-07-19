
package pe.isil.dae_01_pa4.business_logic;

import java.util.ArrayList;

import pe.isil.dae_01_pa4.model.beans.Academia;
import pe.isil.dae_01_pa4.model.data_access.DA_Academia;

public class BL_Academia {

    DA_Academia da_academia = new DA_Academia();

    // Obtener todas las academias
    public ArrayList<Academia> getAll() {
        return da_academia.getAll();
    }

    // Obtener academia por ID
    public Academia getById(int id) {
        return da_academia.getById(id);
    }

    // Agregar academia
    public boolean add(Academia academia) {
        return da_academia.add(academia);
    }

    // Actualizar academia
    public boolean update(Academia academia) {
        return da_academia.update(academia);
    }

    // Eliminar academia
    public boolean delete(int id) {
        return da_academia.delete(id);
    }

    // Verificar si el RUC ya está registrado
    public boolean rucExiste(String ruc) {
        return da_academia.rucExiste(ruc);
    }
}

