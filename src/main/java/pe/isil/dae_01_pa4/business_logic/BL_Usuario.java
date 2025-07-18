
package pe.isil.dae_01_pa4.business_logic;

import java.util.ArrayList;
import pe.isil.dae_01_pa4.model.beans.Usuario;
import pe.isil.dae_01_pa4.model.data_access.DA_Usuario;

public class BL_Usuario {

    private DA_Usuario da_usuario = new DA_Usuario();

    // Listar todos los usuarios
    public ArrayList<Usuario> getAll() {
        return da_usuario.getAll();
    }

    // Obtener usuario por username (para login)
    public Usuario getByUsername(String username) {
        return da_usuario.getByUsername(username);
    }

    // Obtener usuario por ID
    public Usuario getById(int id_usuario) {
        return da_usuario.getById(id_usuario);
    }

    // Registrar un nuevo usuario
    public boolean add(Usuario usuario) {
        return da_usuario.add(usuario);
    }

    // Actualizar usuario
    public boolean update(Usuario usuario) {
        return da_usuario.update(usuario);
    }

    // Eliminar usuario
    public boolean delete(int id_usuario) {
        return da_usuario.delete(id_usuario);
    }

    // Validar si el username ya existe
    public boolean usernameExiste(String username) {
        return da_usuario.usernameExiste(username);
    }

    // Validar si el DNI ya existe
    public boolean dniExiste(String dni) {
        return da_usuario.dniExiste(dni);
    }

    // Autenticación de usuario (login)
    public Usuario autenticar(String username, String password) {
        Usuario usuario = da_usuario.getByUsername(username);
        if (usuario != null) {
            // Aquí deberías comparar con la contraseña encriptada
            // Usar PasswordUtils.verify(password, usuario.getPassword());
            if (usuario.getPassword().equals(password)) { // Reemplaza por encriptación segura
                return usuario;
            }
        }
        return null;
    }
}