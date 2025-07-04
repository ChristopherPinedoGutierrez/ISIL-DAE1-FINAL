
package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.isil.dae_01_pa4.business_logic.BL_Llave;
import pe.isil.dae_01_pa4.model.beans.Llave;
import pe.isil.dae_01_pa4.model.beans.Karateca;

@WebServlet(name = "LlaveController", urlPatterns = {"/llave"})
public class LlaveController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LlaveController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LlaveController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
//    BL_Academia bl_academia = new BL_Academia();
    BL_Llave bl_llave = new BL_Llave();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null || action.equals("ver")) {
            ArrayList<Llave> llaves = bl_llave.getAll();
            request.setAttribute("llaves", llaves);
            
            // NUEVO: obtener karatecas ordenados y enviarlos a la JSP
            List<Karateca> karatecasOrdenados = bl_llave.getKaratecasOrdenados();
            request.setAttribute("karatecasOrdenados", karatecasOrdenados);
            
//            ArrayList<Academia> academias = bl_academia.getAll();
//            request.setAttribute("academias", academias);
            
            request.getRequestDispatcher("pages/llaves.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("generar".equals(action)) {
            // Paso 1: obtener karatecas ordenados
            List<Karateca> karatecasOrdenados = bl_llave.getKaratecasOrdenados();

            // Paso 2: validar que sean par
            if (karatecasOrdenados.size() % 2 != 0) {
                request.setAttribute("error", "La cantidad de karatecas debe ser par para generar las llaves.");
                request.setAttribute("karatecasOrdenados", karatecasOrdenados);
                request.getRequestDispatcher("pages/llaves.jsp").forward(request, response);
                return;
            }

            // Paso 3: generar las rondas y guardar en la BD
            List<Llave> llavesGeneradas = bl_llave.generarLlavesTorneo(karatecasOrdenados);

            // Paso 4: obtener todas las llaves para mostrar
            ArrayList<Llave> llaves = bl_llave.getAll();

            // Paso 5: encontrar el campeón (ganador final)
            Karateca campeon = null;
            if (!llavesGeneradas.isEmpty()) {
                int idCampeon = llavesGeneradas.get(llavesGeneradas.size() - 1).getGanador();
                campeon = bl_llave.getKaratecaById(idCampeon);
            }

//            ArrayList<Academia> academias = bl_academia.getAll();
//            request.setAttribute("academias", academias);
            request.setAttribute("llaves", llaves);
            request.setAttribute("karatecasOrdenados", karatecasOrdenados);
            request.setAttribute("campeon", campeon);
            request.setAttribute("mensaje", "Llaves generadas correctamente.");
            request.getRequestDispatcher("pages/llaves.jsp").forward(request, response);

        } else {
            response.sendRedirect("index.jsp");
        }
        
    }
    
    // Método de agrupamiento simple por rango ±1, edad ±2 años, peso ±5 kg
//    private List<List<Karateca>> agruparKaratecas(List<Karateca> lista) {
//        List<List<Karateca>> grupos = new ArrayList<>();
//        boolean[] usados = new boolean[lista.size()];
//
//        for (int i = 0; i < lista.size(); i++) {
//            if (usados[i]) continue;
//            Karateca k1 = lista.get(i);
//            List<Karateca> grupo = new ArrayList<>();
//            grupo.add(k1);
//            usados[i] = true;
//
//            for (int j = i + 1; j < lista.size(); j++) {
//                if (usados[j]) continue;
//                Karateca k2 = lista.get(j);
//                if (Math.abs(k1.getEdad() - k2.getEdad()) <= 2 &&
//                    Math.abs(k1.getPeso() - k2.getPeso()) <= 5 &&
//                    Math.abs(k1.getRango() - k2.getRango()) <= 1) {
//                    grupo.add(k2);
//                    usados[j] = true;
//                }
//            }
//
//            grupos.add(grupo);
//        }
//
//        return grupos;
//    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
