package pe.isil.dae_01_pa4.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.isil.dae_01_pa4.business_logic.BL_Karateca;
import pe.isil.dae_01_pa4.business_logic.BL_Academia;
import pe.isil.dae_01_pa4.model.beans.Karateca;
import pe.isil.dae_01_pa4.model.beans.Academia;

@WebServlet(name = "KaratecaController", urlPatterns = {"/karateca"})
public class KaratecaController extends HttpServlet {

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

        } else if ("new".equals(action)) {
            // Mostrar formulario para agregar karateca
            ArrayList<Academia> academias = bl_academia.getAll();
            request.setAttribute("academias", academias);
            request.setAttribute("modo", "new");
            request.getRequestDispatcher("pages/karateca_form.jsp").forward(request, response);

        } else if ("edit".equals(action)) {
            // Mostrar formulario para editar karateca
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Karateca karateca = bl_karateca.getById(id);
                    ArrayList<Academia> academias = bl_academia.getAll();
                    if (karateca != null) {
                        request.setAttribute("karateca", karateca);
                        request.setAttribute("academias", academias);
                        request.setAttribute("modo", "edit");
                        request.getRequestDispatcher("pages/karateca_form.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    // id inválido, ignorar
                }
            }
            // Si no hay id o no se encuentra, volver a listar
            response.sendRedirect("karateca?action=listar");
        } else {
            // Acción no reconocida, volver a listar
            response.sendRedirect("karateca?action=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("new".equals(action)) {
            // Registrar karateca
            String dni = request.getParameter("dni");
            String nombreCompleto = request.getParameter("nombre_completo");
            int edad = Integer.parseInt(request.getParameter("edad"));
            double peso = Double.parseDouble(request.getParameter("peso"));
            String sexo = request.getParameter("sexo");
            int rango = Integer.parseInt(request.getParameter("rango"));
            int idLiga = Integer.parseInt(request.getParameter("id_liga"));
            String modalidad = request.getParameter("modalidad") != null
                ? request.getParameter("modalidad")
                : "KUMITE";

            Karateca karateca = new Karateca();
            karateca.setDni(dni);
            karateca.setNombreCompleto(nombreCompleto);
            karateca.setEdad(edad);
            karateca.setPeso(peso);
            karateca.setSexo(sexo);
            karateca.setRango(rango);
            karateca.setModalidad(modalidad);
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

        } else if ("edit".equals(action)) {
            // Actualizar karateca
            String idStr = request.getParameter("id");
            String dni = request.getParameter("dni");
            String nombreCompleto = request.getParameter("nombre_completo");
            int edad = Integer.parseInt(request.getParameter("edad"));
            double peso = Double.parseDouble(request.getParameter("peso"));
            String sexo = request.getParameter("sexo");
            int rango = Integer.parseInt(request.getParameter("rango"));
            int idLiga = Integer.parseInt(request.getParameter("id_liga"));
            String modalidad = request.getParameter("modalidad") != null
                ? request.getParameter("modalidad")
                : "KUMITE";

            boolean actualizado = false;
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Karateca karateca = new Karateca();
                    karateca.setIdKarateca(id);
                    karateca.setDni(dni);
                    karateca.setNombreCompleto(nombreCompleto);
                    karateca.setEdad(edad);
                    karateca.setPeso(peso);
                    karateca.setSexo(sexo);
                    karateca.setRango(rango);
                    karateca.setModalidad(modalidad);
                    karateca.setIdLiga(idLiga);

                    actualizado = bl_karateca.update(karateca);
                } catch (NumberFormatException e) {
                    actualizado = false;
                }
            }
            if (actualizado) {
                request.setAttribute("mensaje", "Karateca actualizado correctamente.");
            } else {
                request.setAttribute("mensaje", "Error al actualizar el karateca.");
            }
            ArrayList<Karateca> lista = bl_karateca.getAll();
            ArrayList<Academia> academias = bl_academia.getAll();
            request.setAttribute("listaKaratecas", lista);
            request.setAttribute("listaAcademias", academias);
            request.getRequestDispatcher("pages/karatecas.jsp").forward(request, response);

        } else if ("delete".equals(action)) {
            // Eliminar karateca por POST
            String idStr = request.getParameter("id");
            boolean eliminado = false;
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    eliminado = bl_karateca.delete(id);
                } catch (NumberFormatException e) {
                    eliminado = false;
                }
            }
            if (eliminado) {
                request.setAttribute("mensaje", "Karateca eliminado correctamente.");
            } else {
                request.setAttribute("mensaje", "Error al eliminar el karateca.");
            }
            ArrayList<Karateca> lista = bl_karateca.getAll();
            ArrayList<Academia> academias = bl_academia.getAll();
            request.setAttribute("listaKaratecas", lista);
            request.setAttribute("listaAcademias", academias);
            request.getRequestDispatcher("pages/karatecas.jsp").forward(request, response);

        } else {
            response.sendRedirect("karateca?action=listar");
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador para CRUD de karatecas";
    }
}