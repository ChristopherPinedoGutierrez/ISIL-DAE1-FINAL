
package pe.isil.dae_01_pa4.model.data_access;

import java.sql.*;
import java.util.*;

import pe.isil.dae_01_pa4.model.beans.Karateca;
import pe.isil.dae_01_pa4.model.beans.Llave;


public class DA_Llave {

    private PreparedStatement pst = null;
    private ResultSet rst;

    // Obtener todas las llaves generadas
    public ArrayList<Llave> getAll() {
        ArrayList<Llave> llaves = new ArrayList<>();
        Llave llave;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM llave ORDER BY ronda";
                pst = conexion.prepareStatement(SQL);
                rst = pst.executeQuery();

                while (rst.next()) {
                    llave = new Llave();
                    llave.setIdLlave(rst.getInt("id_llave"));
                    llave.setIdKarateca1(rst.getInt("id_karateca1"));
                    llave.setIdKarateca2(rst.getInt("id_karateca2"));
                    llave.setRonda(rst.getInt("ronda"));
                    llave.setGanador((Integer) rst.getObject("ganador")); // puede ser null
                    llaves.add(llave);
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return llaves;
    }
    
    public boolean add(Llave llave) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();
            String SQL = "INSERT INTO llave(id_karateca1, id_karateca2, ronda, ganador) VALUES (?, ?, ?, ?)";
            pst = conexion.prepareStatement(SQL);
            pst.setInt(1, llave.getIdKarateca1());
            pst.setInt(2, llave.getIdKarateca2());
            pst.setInt(3, llave.getRonda());

            if (llave.getGanador() != null) {
                pst.setInt(4, llave.getGanador());
            } else {
                pst.setNull(4, java.sql.Types.INTEGER);
            }

            if (pst.executeUpdate() > 0) resultado = true;

        } catch (SQLException e) {
            System.out.println("Error DAO add Llave: " + e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }

    // Borrar todas las llaves actuales (antes de generar nuevas)
    public boolean deleteAll() {
        Connection conexion = null;
        boolean resultado = false;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "DELETE FROM llave";
                pst = conexion.prepareStatement(SQL);
                if (pst.executeUpdate() >= 0) {
                    resultado = true;
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }

    // Generar llaves de torneo (emparejar aleatoriamente por criterios)
    public boolean generarLlaves(ArrayList<Karateca> listaKaratecas) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                // 1. Agrupar por edad, peso y rango
                listaKaratecas.sort(Comparator.comparing(Karateca::getEdad)
                                              .thenComparing(Karateca::getPeso)
                                              .thenComparing(Karateca::getRango));

                // 2. Mezclar ligeramente para no ser tan predecible
                Collections.shuffle(listaKaratecas);

                // 3. Agrupar de 2 en 2 y generar llaves
                int ronda = 1;
                String SQL = "INSERT INTO llave(id_karateca1, id_karateca2, ronda) VALUES (?, ?, ?)";
                pst = conexion.prepareStatement(SQL);

                for (int i = 0; i < listaKaratecas.size() - 1; i += 2) {
                    Karateca k1 = listaKaratecas.get(i);
                    Karateca k2 = listaKaratecas.get(i + 1);

                    pst.setInt(1, k1.getIdKarateca());
                    pst.setInt(2, k2.getIdKarateca());
                    pst.setInt(3, ronda);
                    pst.addBatch();
                }

                // 4. Ejecutar lote de inserts
                int[] resultados = pst.executeBatch();
                resultado = resultados.length > 0;

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }
}

