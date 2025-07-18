
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

@WebServlet(name = "UsuarioController", urlPatterns = {"/Usuarios"})
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
                bl_usuario.delete(idDelete);
                response.sendRedirect("usuarios");
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
        // Captura datos del formulario
        String idStr = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String rol = request.getParameter("rol");
        String dni = request.getParameter("dni");

        Usuario usuario = new Usuario();
        usuario.setUsername(username);
        usuario.setNombre(nombre);
        usuario.setRol(rol);
        usuario.setDni(dni);

        // Si se ingresa contraseña, se encripta
        if (password != null && !password.trim().isEmpty()) {
            usuario.setPassword(PasswordUtils.hash(password));
        }

        boolean ok;
        if (idStr == null || idStr.isEmpty()) {
            // Nuevo usuario
            ok = bl_usuario.add(usuario);
        } else {
            // Editar usuario existente
            usuario.setIdUsuario(Integer.parseInt(idStr));
            ok = bl_usuario.update(usuario);
        }

        response.sendRedirect("usuarios");
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
