
package pe.isil.dae_01_pa4.business_logic;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Random;
import pe.isil.dae_01_pa4.model.beans.Karateca;
import pe.isil.dae_01_pa4.model.beans.Llave;
import pe.isil.dae_01_pa4.model.data_access.DA_Karateca;
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
    
    public Karateca getKaratecaById(int idKarateca) {
        DA_Karateca da_karateca = new DA_Karateca();
        return da_karateca.getById(idKarateca);
    }
    
    public ArrayList<Karateca> getKaratecasOrdenados() {
        DA_Karateca da_karateca = new DA_Karateca();
        ArrayList<Karateca> lista = da_karateca.getAll();
        lista.sort(Comparator .comparing(Karateca::getEdad)
                              .thenComparing(Karateca::getPeso)
                              .thenComparing(Karateca::getRango));
        return lista;
    }
    
    public List<Llave> generarLlavesTorneo(List<Karateca> karatecasOrdenados) {
        // Eliminar todas las rondas previas
        deleteAll();

        List<Llave> todasLasLlaves = new ArrayList<>();
        List<Karateca> participantes = new ArrayList<>(karatecasOrdenados);
        Random rand = new Random();
        int ronda = 1;

        while (participantes.size() > 1) {
            List<Karateca> ganadores = new ArrayList<>();
            for (int i = 0; i < participantes.size(); i += 2) {
                Karateca k1 = participantes.get(i);
                Karateca k2 = participantes.get(i + 1);
                // Ganador aleatorio
                Karateca ganador = rand.nextBoolean() ? k1 : k2;

                Llave llave = new Llave();
                llave.setIdKarateca1(k1.getIdKarateca());
                llave.setIdKarateca2(k2.getIdKarateca());
                llave.setRonda(ronda);
                llave.setGanador(ganador.getIdKarateca());

                // Guardar en la BD
                add(llave);
                todasLasLlaves.add(llave);

                ganadores.add(ganador);
            }
            participantes = ganadores;
            ronda++;
        }
        return todasLasLlaves;
    }
}

