package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
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

    BL_Llave bl_llave = new BL_Llave();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Solo mostrar karatecas ordenados. NO mandar llaves ni campeón ni generado.
        if (action == null || action.equals("ver")) {
            List<Karateca> karatecasOrdenados = bl_llave.getKaratecasOrdenados();
            request.setAttribute("karatecasOrdenados", karatecasOrdenados);

            // NO enviar llaves, campeón ni generado aquí
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
                // Solo mostrar tabla 1
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

            // Solo en este flujo enviamos llaves, campeón y el flag generado=true
            request.setAttribute("llaves", llaves);
            request.setAttribute("karatecasOrdenados", karatecasOrdenados);
            request.setAttribute("campeon", campeon);
            request.setAttribute("generado", true);
            request.setAttribute("mensaje", "Llaves generadas correctamente.");
            request.getRequestDispatcher("pages/llaves.jsp").forward(request, response);

        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "LlaveController - gestión de llaves y campeón del torneo";
    }
}