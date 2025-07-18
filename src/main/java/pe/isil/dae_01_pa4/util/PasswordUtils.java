
package pe.isil.dae_01_pa4.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtils {

    // Encripta la contraseña usando SHA-256
    public static String hash(String password) {
        StringBuilder sb = new StringBuilder();
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error al encriptar contraseña: " + e.getMessage());
        }
        return sb.toString();
    }

    // Verifica si la contraseña en texto coincide con el hash guardado
    public static boolean verify(String password, String hash) {
        return hash(password).equals(hash);
    }
}
