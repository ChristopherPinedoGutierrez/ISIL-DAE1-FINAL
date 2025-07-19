
package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.isil.dae_01_pa4.business_logic.BL_Academia;
import pe.isil.dae_01_pa4.model.beans.Academia;

@WebServlet(name = "AcademiaController", urlPatterns = {"/academia"})
public class AcademiaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AcademiaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AcademiaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    BL_Academia bl_academia = new BL_Academia();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null || action.equals("listar")) {
            ArrayList<Academia> lista = bl_academia.getAll();
            request.setAttribute("academias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);
        } else if ("new".equals(action)) {
            // Mostrar formulario para agregar academia
            request.setAttribute("modo", "new");
            request.getRequestDispatcher("pages/academia_form.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Mostrar formulario para editar academia
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Academia academia = bl_academia.getById(id);
                    if (academia != null) {
                        request.setAttribute("academia", academia);
                        request.setAttribute("modo", "edit");
                        request.getRequestDispatcher("pages/academia_form.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // id inválido, ignorar
                }
            }
            // Si no hay id o no se encuentra, volver a listar
            response.sendRedirect("academia?action=listar");
        } else {
            // Acción no reconocida, volver a listar
            response.sendRedirect("academia?action=listar");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("new".equals(action)) {
            String nombre = request.getParameter("nombre");
            String ruc = request.getParameter("ruc");

            if (bl_academia.rucExiste(ruc)) {
                request.setAttribute("mensaje", "El RUC ya está registrado.");
            } else {
                Academia academia = new Academia();
                academia.setNombre(nombre);
                academia.setRuc(ruc);

                boolean insertado = bl_academia.add(academia);
                if (insertado) {
                    request.setAttribute("mensaje", "Academia registrada correctamente.");
                } else {
                    request.setAttribute("mensaje", "Error al registrar la academia.");
                }
            }
            // Volver a la lista principal
            ArrayList<Academia> lista = bl_academia.getAll();
            request.setAttribute("academias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);

        } else if ("edit".equals(action)) {
            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String ruc = request.getParameter("ruc");
            boolean actualizado = false;
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Academia academia = new Academia();
                    academia.setIdLiga(id);
                    academia.setNombre(nombre);
                    academia.setRuc(ruc);

                    actualizado = bl_academia.update(academia);
                } catch (NumberFormatException e) {
                    actualizado = false;
                }
            }
            if (actualizado) {
                request.setAttribute("mensaje", "Academia actualizada correctamente.");
            } else {
                request.setAttribute("mensaje", "Error al actualizar la academia.");
            }
            ArrayList<Academia> lista = bl_academia.getAll();
            request.setAttribute("academias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);

        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            boolean eliminado = false;
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    eliminado = bl_academia.delete(id);
                } catch (NumberFormatException e) {
                    eliminado = false;
                }
            }
            if (eliminado) {
                request.setAttribute("mensaje", "Academia eliminada correctamente.");
            } else {
                request.setAttribute("mensaje", "Error al eliminar la academia.");
            }
            ArrayList<Academia> lista = bl_academia.getAll();
            request.setAttribute("academias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);

        } else {
            response.sendRedirect("academia?action=listar");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Controlador para CRUD de academias";
    }// </editor-fold>

}
