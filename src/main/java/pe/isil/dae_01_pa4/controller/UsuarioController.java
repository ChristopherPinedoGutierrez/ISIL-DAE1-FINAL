
package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.isil.dae_01_pa4.business_logic.BL_Usuario;
import pe.isil.dae_01_pa4.model.beans.Usuario;
import pe.isil.dae_01_pa4.util.PasswordUtils;

@WebServlet(name = "UsuarioController", urlPatterns = {"/usuario"})
public class UsuarioController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UsuarioController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UsuarioController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private BL_Usuario bl_usuario = new BL_Usuario();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("pages/usuario_form.jsp").forward(request, response);
                break;
            case "edit":
                int idEdit = Integer.parseInt(request.getParameter("id"));
                Usuario usuarioEdit = bl_usuario.getById(idEdit);
                request.setAttribute("usuario", usuarioEdit);
                request.getRequestDispatcher("pages/usuario_form.jsp").forward(request, response);
                break;
            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                boolean okDelete = bl_usuario.delete(idDelete);
                String mensaje = okDelete ? "Usuario eliminado correctamente."
                                          : "No se pudo eliminar el usuario.";
                String tipoMensaje = okDelete ? "success" : "danger";
                List<Usuario> usuariosAfterDelete = bl_usuario.getAll();
                request.setAttribute("usuarios", usuariosAfterDelete);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("tipoMensaje", tipoMensaje);
                request.getRequestDispatcher("pages/usuarios.jsp").forward(request, response);
                break;
                case "register":
                // Muestra el formulario público de registro
                request.getRequestDispatcher("pages/register.jsp").forward(request, response);
                break;
            case "list":
            default:
                List<Usuario> usuarios = bl_usuario.getAll();
                request.setAttribute("usuarios", usuarios);
                request.getRequestDispatcher("pages/usuarios.jsp").forward(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("save".equals(action)) {
            String idStr = request.getParameter("idUsuario");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String rol = request.getParameter("rol");
            String dni = request.getParameter("dni");

            Usuario usuario = new Usuario();
            usuario.setUsername(username);
            usuario.setNombre(nombre);
            usuario.setApellido(apellido);
            usuario.setRol(rol);
            usuario.setDni(dni);

            String mensaje, tipoMensaje;
            if (idStr == null || idStr.isEmpty()) {
                // Crear nuevo usuario (gestión interna)
                if (password != null && !password.trim().isEmpty()) {
                    usuario.setPassword(PasswordUtils.hash(password));
                } else {
                    usuario.setPassword(null); // O lanza error si es obligatorio
                }
                boolean ok = bl_usuario.add(usuario);
                mensaje = ok ? "Usuario creado correctamente." : "Hubo un error al crear el usuario.";
                tipoMensaje = ok ? "success" : "danger";
                if (ok) {
                    List<Usuario> usuarios = bl_usuario.getAll();
                    request.setAttribute("usuarios", usuarios);
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("tipoMensaje", tipoMensaje);
                    request.getRequestDispatcher("pages/usuarios.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("tipoMensaje", tipoMensaje);
                    request.getRequestDispatcher("pages/usuario_form.jsp").forward(request, response);
                }
            } else {
                // Editar usuario existente (gestión interna)
                usuario.setIdUsuario(Integer.parseInt(idStr));
                if (password != null && !password.trim().isEmpty()) {
                    usuario.setPassword(PasswordUtils.hash(password));
                } else {
                    // Mantén la contraseña anterior
                    Usuario usuarioBD = bl_usuario.getById(usuario.getIdUsuario());
                    usuario.setPassword(usuarioBD.getPassword());
                }
                boolean ok = bl_usuario.update(usuario);
                mensaje = ok ? "Usuario actualizado correctamente." : "Hubo un error al actualizar el usuario.";
                tipoMensaje = ok ? "success" : "danger";
                if (ok) {
                    List<Usuario> usuarios = bl_usuario.getAll();
                    request.setAttribute("usuarios", usuarios);
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("tipoMensaje", tipoMensaje);
                    request.getRequestDispatcher("pages/usuarios.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("tipoMensaje", tipoMensaje);
                    request.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("pages/usuario_form.jsp").forward(request, response);
                }
            }
        } else if ("register".equals(action)) {
            // Registro público de usuario
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String rol = "usuario"; // Puedes ajustar el rol por defecto
            String dni = request.getParameter("dni");

            Usuario usuario = new Usuario();
            usuario.setUsername(username);
            usuario.setNombre(nombre);
            usuario.setApellido(apellido);
            usuario.setRol(rol);
            usuario.setDni(dni);

            if (password != null && !password.trim().isEmpty()) {
                usuario.setPassword(PasswordUtils.hash(password));
            }

            if (bl_usuario.getByUsername(username) != null) {
                request.setAttribute("mensaje", "El usuario ya existe");
                request.setAttribute("tipoMensaje", "danger");
                request.getRequestDispatcher("pages/register.jsp").forward(request, response);
            } else {
                boolean ok = bl_usuario.add(usuario);
                if (ok) {
                    request.setAttribute("mensaje", "Usuario registrado correctamente. Puedes ingresar.");
                    request.setAttribute("tipoMensaje", "success");
                    request.getRequestDispatcher("pages/login.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", "Hubo un error al registrar el usuario.");
                    request.setAttribute("tipoMensaje", "danger");
                    request.getRequestDispatcher("pages/register.jsp").forward(request, response);
                }
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción POST desconocida.");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
