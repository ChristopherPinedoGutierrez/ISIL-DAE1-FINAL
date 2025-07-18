
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

@WebServlet(name = "AcademiaController", urlPatterns = {"/academias"})
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
            request.setAttribute("listaAcademias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("registrar".equals(action)) {
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

            ArrayList<Academia> lista = bl_academia.getAll();
            request.setAttribute("listaAcademias", lista);
            request.getRequestDispatcher("pages/academias.jsp").forward(request, response);

        } else {
            response.sendRedirect("index.jsp");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
