
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
import pe.isil.dae_01_pa4.business_logic.BL_Karateca;
import pe.isil.dae_01_pa4.model.beans.Academia;
import pe.isil.dae_01_pa4.model.beans.Karateca;

@WebServlet(name = "KaratecaController", urlPatterns = {"/karateca"})
public class KaratecaController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet KaratecaController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet KaratecaController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    BL_Karateca bl_karateca = new BL_Karateca();
    BL_Academia bl_academia = new BL_Academia();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null || action.equals("listar")) {
            ArrayList<Karateca> lista = bl_karateca.getAll();
            ArrayList<Academia> academias = bl_academia.getAll();

            request.setAttribute("listaKaratecas", lista);
            request.setAttribute("listaAcademias", academias);

            request.getRequestDispatcher("pages/karatecas.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
         String action = request.getParameter("action");

        if ("registrar".equals(action)) {
            String dni = request.getParameter("dni");
            String nombreCompleto = request.getParameter("nombre_completo");
            int edad = Integer.parseInt(request.getParameter("edad"));
            double peso = Double.parseDouble(request.getParameter("peso"));
            String sexo = request.getParameter("sexo");
            int rango = Integer.parseInt(request.getParameter("rango"));
            int idLiga = Integer.parseInt(request.getParameter("id_liga"));

            Karateca karateca = new Karateca();
            karateca.setDni(dni);
            karateca.setNombreCompleto(nombreCompleto);
            karateca.setEdad(edad);
            karateca.setPeso(peso);
            karateca.setSexo(sexo);
            karateca.setRango(rango);
            karateca.setModalidad("KUMITE"); // Fijo como indica el enunciado
            karateca.setIdLiga(idLiga);

            boolean insertado = bl_karateca.add(karateca);
            if (insertado) {
                request.setAttribute("mensaje", "✅ Karateca registrado correctamente.");
            } else {
                request.setAttribute("mensaje", "❌ Error al registrar el karateca.");
            }

            ArrayList<Karateca> lista = bl_karateca.getAll();
            ArrayList<Academia> academias = bl_academia.getAll();

            request.setAttribute("listaKaratecas", lista);
            request.setAttribute("listaAcademias", academias);
            request.getRequestDispatcher("pages/karatecas.jsp").forward(request, response);

        } else {
            response.sendRedirect("index.jsp");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
