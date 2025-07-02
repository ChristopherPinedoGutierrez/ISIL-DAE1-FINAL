
package pe.isil.dae_01_pa4.model.data_access;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConexionDB {
    
    // Atributos de conexión
    private String username = "root";
    private String password = "Qwerty123_";
    private String database = "torneo_karate";
    private String host = "localhost";
    private String puerto = "3309";
    
    // Atributos adicionales
    private Connection conexion;
    private static ConexionDB instancia;

    // Constructor
    public ConexionDB() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + host + ":" + puerto + "/" + database + "?serverTimezone=America/Lima";
            conexion = DriverManager.getConnection(url, username, password);
            System.out.println("Conexión exitosa a la base de datos");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConexion() {
        if (conexion == null) {
            instancia = new ConexionDB();
        }
        return conexion;
    }

    public static ConexionDB getInstancia() {
        if (instancia != null) {
            return instancia;
        }
        instancia = new ConexionDB();
        return instancia;
    }

    public void close(Connection conexion) {
        try {
            if (conexion != null) {
                conexion.close();
                instancia = null;
                if (conexion.isClosed()) {
                    System.out.println("Conexión cerrada a la base de datos");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConexionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

