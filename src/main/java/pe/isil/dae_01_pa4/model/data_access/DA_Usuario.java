
package pe.isil.dae_01_pa4.model.data_access;

import java.sql.*;
import java.util.ArrayList;

import pe.isil.dae_01_pa4.model.beans.Usuario;

public class DA_Usuario {

    private PreparedStatement pst = null;
    private ResultSet rst;

    // Obtener todos los usuarios
    public ArrayList<Usuario> getAll() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        Usuario usuario;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM usuario ORDER BY nombre";
                pst = conexion.prepareStatement(SQL);
                rst = pst.executeQuery();

                while (rst.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rst.getInt("id_usuario"));
                    usuario.setNombre(rst.getString("nombre"));
                    usuario.setApellido(rst.getString("apellido"));
                    usuario.setDni(rst.getString("dni"));
                    usuario.setUsername(rst.getString("username"));
                    usuario.setPassword(rst.getString("password"));
                    usuario.setRol(rst.getString("rol"));
                    usuarios.add(usuario);
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return usuarios;
    }

    // Obtener usuario por username
    public Usuario getByUsername(String username) {
        Usuario usuario = null;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM usuario WHERE username = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, username);
                rst = pst.executeQuery();

                if (rst.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rst.getInt("id_usuario"));
                    usuario.setNombre(rst.getString("nombre"));
                    usuario.setApellido(rst.getString("apellido"));
                    usuario.setDni(rst.getString("dni"));
                    usuario.setUsername(rst.getString("username"));
                    usuario.setPassword(rst.getString("password"));
                    usuario.setRol(rst.getString("rol"));
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return usuario;
    }

    // Obtener usuario por ID
    public Usuario getById(int idUsuario) {
        Usuario usuario = null;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT * FROM usuario WHERE id_usuario = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setInt(1, idUsuario);
                rst = pst.executeQuery();

                if (rst.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rst.getInt("id_usuario"));
                    usuario.setNombre(rst.getString("nombre"));
                    usuario.setApellido(rst.getString("apellido"));
                    usuario.setDni(rst.getString("dni"));
                    usuario.setUsername(rst.getString("username"));
                    usuario.setPassword(rst.getString("password"));
                    usuario.setRol(rst.getString("rol"));
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return usuario;
    }

    // Insertar nuevo usuario
    public boolean add(Usuario usuario) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "INSERT INTO usuario(nombre, apellido, dni, username, password, rol) VALUES (?, ?, ?, ?, ?, ?)";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, usuario.getNombre());
                pst.setString(2, usuario.getApellido());
                pst.setString(3, usuario.getDni());
                pst.setString(4, usuario.getUsername());
                pst.setString(5, usuario.getPassword()); // encriptada!
                pst.setString(6, usuario.getRol());

                if (pst.executeUpdate() > 0) {
                    resultado = true;
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println("Error DAO add Usuario: " + e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }

    // Actualizar usuario
    public boolean update(Usuario usuario) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "UPDATE usuario SET nombre=?, apellido=?, dni=?, username=?, password=?, rol=? WHERE id_usuario=?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, usuario.getNombre());
                pst.setString(2, usuario.getApellido());
                pst.setString(3, usuario.getDni());
                pst.setString(4, usuario.getUsername());
                pst.setString(5, usuario.getPassword()); // encriptada!
                pst.setString(6, usuario.getRol());
                pst.setInt(7, usuario.getIdUsuario());

                if (pst.executeUpdate() > 0) {
                    resultado = true;
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println("Error DAO update Usuario: " + e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }

    // Eliminar usuario
    public boolean delete(int idUsuario) {
        boolean resultado = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "DELETE FROM usuario WHERE id_usuario=?";
                pst = conexion.prepareStatement(SQL);
                pst.setInt(1, idUsuario);

                if (pst.executeUpdate() > 0) {
                    resultado = true;
                }

            } else {
                System.out.println("Error en la conexión a la base de datos");
            }

        } catch (SQLException e) {
            System.out.println("Error DAO delete Usuario: " + e.getMessage());
        } finally {
            ConexionDB.getInstancia().close(conexion);
        }

        return resultado;
    }

    // Validar si el username existe
    public boolean usernameExiste(String username) {
        boolean existe = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT COUNT(*) FROM usuario WHERE username = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, username);
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

    // Validar si el DNI existe
    public boolean dniExiste(String dni) {
        boolean existe = false;
        Connection conexion = null;

        try {
            conexion = ConexionDB.getInstancia().getConexion();

            if (conexion != null) {
                String SQL = "SELECT COUNT(*) FROM usuario WHERE dni = ?";
                pst = conexion.prepareStatement(SQL);
                pst.setString(1, dni);
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
