
package pe.isil.dae_01_pa4.model.data_access;

import java.sql.*;
import java.util.ArrayList;

import pe.isil.dae_01_pa4.model.beans.Karateca;

public class DA_Karateca {

    private PreparedStatement pst = null;
    private ResultSet rst;

    // Obtener todos los karatecas
    public ArrayList<Karateca> getAll() {
        ArrayList<Karateca> lista = new ArrayList<>();
        Karateca karateca;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM karateca ORDER BY nombre_completo";
                pst = conexion.prepareStatement(SQL);
                rst = pst.executeQuery();

                while (rst.next()) {
                    karateca = new Karateca();
                    karateca.setIdKarateca(rst.getInt("id_karateca"));
                    karateca.setDni(rst.getString("dni"));
                    karateca.setNombreCompleto(rst.getString("nombre_completo"));
                    karateca.setEdad(rst.getInt("edad"));
                    karateca.setPeso(rst.getDouble("peso"));
                    karateca.setSexo(rst.getString("sexo"));
                    karateca.setRango(rst.getInt("rango"));
                    karateca.setModalidad(rst.getString("modalidad"));
                    karateca.setIdLiga(rst.getInt("id_liga"));
                    lista.add(karateca);
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return lista;
    }

    // Insertar nuevo karateca
    public boolean add(Karateca karateca) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "INSERT INTO karateca(dni, nombre_completo, edad, peso, sexo, rango, modalidad, id_liga) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, karateca.getDni());
                pst.setString(2, karateca.getNombreCompleto());
                pst.setInt(3, karateca.getEdad());
                pst.setDouble(4, karateca.getPeso());
                pst.setString(5, karateca.getSexo());
                pst.setInt(6, karateca.getRango());
                pst.setString(7, karateca.getModalidad());
                pst.setInt(8, karateca.getIdLiga());

                if (pst.executeUpdate() > 0) {
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

    // Obtener karateca por ID
    public Karateca getById(int id) {
        Karateca k = new Karateca();
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM karateca WHERE id_karateca = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setInt(1, id);
                rst = pst.executeQuery();

                if (rst.next()) {
                    k.setIdKarateca(rst.getInt("id_karateca"));
                    k.setDni(rst.getString("dni"));
                    k.setNombreCompleto(rst.getString("nombre_completo"));
                    k.setEdad(rst.getInt("edad"));
                    k.setPeso(rst.getDouble("peso"));
                    k.setSexo(rst.getString("sexo"));
                    k.setRango(rst.getInt("rango"));
                    k.setModalidad(rst.getString("modalidad"));
                    k.setIdLiga(rst.getInt("id_liga"));
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return k;
    }
}

