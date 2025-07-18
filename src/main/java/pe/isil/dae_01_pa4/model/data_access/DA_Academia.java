package pe.isil.dae_01_pa4.model.data_access;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import pe.isil.dae_01_pa4.model.beans.Academia;

public class DA_Academia {

    private PreparedStatement pst = null;
    private ResultSet rst;

    // Obtener todas las academias
    public ArrayList<Academia> getAll() {
        ArrayList<Academia> academias = new ArrayList<>();
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM academia ORDER BY nombre";
                pst = conexion.prepareStatement(SQL);
                rst = pst.executeQuery();

                while (rst.next()) {
                    Academia academia = new Academia();
                    academia.setIdLiga(rst.getInt("id_liga"));
                    academia.setNombre(rst.getString("nombre"));
                    academia.setRuc(rst.getString("ruc"));
                    academias.add(academia);
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return academias;
    }

    // Obtener academia por ID
    public Academia getById(int id) {
        Academia academia = null;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();
            if (conexion != null) {
                String SQL = "SELECT * FROM academia WHERE id_liga = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setInt(1, id);
                rst = pst.executeQuery();

                if (rst.next()) {
                    academia = new Academia();
                    academia.setIdLiga(rst.getInt("id_liga"));
                    academia.setNombre(rst.getString("nombre"));
                    academia.setRuc(rst.getString("ruc"));
                }
            } else {
                System.out.println("Error en la conexión a la base de datos");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return academia;
    }

    // Insertar nueva academia
    public boolean add(Academia academia) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "INSERT INTO academia(nombre, ruc) VALUES(?, ?)";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, academia.getNombre());
                pst.setString(2, academia.getRuc());

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

    // Actualizar academia
    public boolean update(Academia academia) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "UPDATE academia SET nombre = ?, ruc = ? WHERE id_liga = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, academia.getNombre());
                pst.setString(2, academia.getRuc());
                pst.setInt(3, academia.getIdLiga());

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

    // Eliminar academia
    public boolean delete(int id) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "DELETE FROM academia WHERE id_liga = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setInt(1, id);

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

    // Verificar si el RUC ya existe
    public boolean rucExiste(String ruc) {
        boolean existe = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT COUNT(*) FROM academia WHERE ruc = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, ruc);
                rst = pst.executeQuery();

                if (rst.next() && rst.getInt(1) > 0) {
                    existe = true;
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return existe;
    }
}