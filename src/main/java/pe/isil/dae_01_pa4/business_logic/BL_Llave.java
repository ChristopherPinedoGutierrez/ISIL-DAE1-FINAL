
package pe.isil.dae_01_pa4.business_logic;

import java.util.ArrayList;
import pe.isil.dae_01_pa4.model.beans.Karateca;
import pe.isil.dae_01_pa4.model.beans.Llave;
import pe.isil.dae_01_pa4.model.data_access.DA_Llave;

public class BL_Llave {

    DA_Llave da_llave = new DA_Llave();

    // Obtener todas las llaves generadas
    public ArrayList<Llave> getAll() {
        return da_llave.getAll();
    }
    
    public boolean add(Llave llave) {
        return da_llave.add(llave);
    }

    // Eliminar todas las llaves existentes (antes de generar nuevas)
    public boolean deleteAll() {
        return da_llave.deleteAll();
    }

    // Generar llaves del torneo en base a los karatecas
    public boolean generarLlaves(ArrayList<Karateca> listaKaratecas) {
        return da_llave.generarLlaves(listaKaratecas);
    }
}

