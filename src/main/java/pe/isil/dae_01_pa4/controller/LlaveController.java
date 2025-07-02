
package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.isil.dae_01_pa4.business_logic.BL_Karateca;
import pe.isil.dae_01_pa4.business_logic.BL_Llave;
import pe.isil.dae_01_pa4.model.beans.Llave;
import pe.isil.dae_01_pa4.model.beans.Karateca;

@WebServlet(name = "LlaveController", urlPatterns = {"/Llaves"})
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
    
    BL_Karateca bl_karateca = new BL_Karateca();
    BL_Llave bl_llave = new BL_Llave();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if (action == null || action.equals("ver")) {
            ArrayList<Llave> llaves = bl_llave.getAll();
            request.setAttribute("llaves", llaves);
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
            // Paso 1: eliminar llaves previas
            bl_llave.deleteAll();

            // Paso 2: obtener todos los karatecas
            ArrayList<Karateca> karatecas = bl_karateca.getAll();

            // Paso 3: agrupar por edad, peso y rango (puedes ajustar los márgenes si deseas)
            List<List<Karateca>> grupos = agruparKaratecas(karatecas);

            // Paso 4: generar llaves por grupo
            for (List<Karateca> grupo : grupos) {
                Collections.shuffle(grupo);
                for (int i = 0; i + 1 < grupo.size(); i += 2) {
                    Karateca k1 = grupo.get(i);
                    Karateca k2 = grupo.get(i + 1);

                    Llave llave = new Llave();
                    llave.setIdKarateca1(k1.getIdKarateca());
                    llave.setIdKarateca2(k2.getIdKarateca());
                    llave.setRonda(1);
                    llave.setGanador(null);

                    bl_llave.add(llave);
                }
            }

            // Paso 5: mostrar nuevas llaves
            ArrayList<Llave> llaves = bl_llave.getAll();
            request.setAttribute("llaves", llaves);
            request.setAttribute("mensaje", "✅ Llaves generadas correctamente.");
            request.getRequestDispatcher("pages/llaves.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
        
    }
    
    // Método de agrupamiento simple por rango ±1, edad ±2 años, peso ±5 kg
    private List<List<Karateca>> agruparKaratecas(List<Karateca> lista) {
        List<List<Karateca>> grupos = new ArrayList<>();
        boolean[] usados = new boolean[lista.size()];

        for (int i = 0; i < lista.size(); i++) {
            if (usados[i]) continue;
            Karateca k1 = lista.get(i);
            List<Karateca> grupo = new ArrayList<>();
            grupo.add(k1);
            usados[i] = true;

            for (int j = i + 1; j < lista.size(); j++) {
                if (usados[j]) continue;
                Karateca k2 = lista.get(j);
                if (Math.abs(k1.getEdad() - k2.getEdad()) <= 2 &&
                    Math.abs(k1.getPeso() - k2.getPeso()) <= 5 &&
                    Math.abs(k1.getRango() - k2.getRango()) <= 1) {
                    grupo.add(k2);
                    usados[j] = true;
                }
            }

            grupos.add(grupo);
        }

        return grupos;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
