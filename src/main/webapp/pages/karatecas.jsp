<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Karateca" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>

<%
    // Se reciben las listas desde el controller
    ArrayList<Karateca> karateca = (ArrayList<Karateca>) request.getAttribute("listaKaratecas");
    ArrayList<Academia> academias = (ArrayList<Academia>) request.getAttribute("listaAcademias");
    String mensaje = (String) request.getAttribute("mensaje");
%>
<%!
    String obtenerNombreAcademia(int idLiga, ArrayList<Academia> academias) {
        if (academias != null) {
            for (Academia a : academias) {
                if (a.getIdLiga() == idLiga) {
                    return a.getNombre();
                }
            }
        }
        return "Sin academia";
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Karatecas</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <section class="mb-5">
        <h2 class="text-primary mb-4">Registro de Karatecas</h2>

        <%-- Muestra mensaje de éxito o error --%>
        <% if (mensaje != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <%-- Formulario de registro de Karateca --%>
        <form action="<%=request.getContextPath()%>/karateca" method="post" class="card p-4 shadow rounded-4 bg-white border-0">
            <input type="hidden" name="action" value="registrar">

            <div class="mb-3">
                <label for="txtNombre" class="form-label fw-semibold">Nombre completo</label>
                <input type="text" class="form-control" id="txtNombre" name="nombre_completo" required>
            </div>

            <div class="mb-3">
                <label for="txtDNI" class="form-label fw-semibold">DNI</label>
                <input type="text" class="form-control" id="txtDNI" name="dni" required maxlength="8" pattern="[0-9]{8}" title="Debe ingresar 8 dígitos">
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="txtEdad" class="form-label fw-semibold">Edad</label>
                    <input type="number" class="form-control" id="txtEdad" name="edad" required min="0">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="txtPeso" class="form-label fw-semibold">Peso (kg)</label>
                    <input type="number" class="form-control" id="txtPeso" name="peso" required min="0" step="any">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="selectSexo" class="form-label fw-semibold">Sexo</label>
                    <select class="form-select" id="selectSexo" name="sexo" required>
                        <option value="">-- Selecciona el sexo --</option>
                        <option value="M">Masculino</option>
                        <option value="F">Femenino</option>
                    </select>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="selectRango" class="form-label fw-semibold">Rango</label>
                    <select class="form-select" id="selectRango" name="rango" required>
                        <option value="">-- Selecciona el rango --</option>
                        <%-- Rango 1 a 10 kyu --%>
                        <% for (int i = 1; i <= 10; i++) { %>
                            <option value="<%= i %>"><%= i %> kyu</option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="selectLiga" class="form-label fw-semibold">Academia</label>
                    <select class="form-select" id="selectLiga" name="id_liga" required>
                        <option value="">-- Selecciona una academia --</option>
                        <%-- Lista dinámica de academias --%>
                        <% if (academias != null) {
                            for (Academia a : academias) { %>
                            <option value="<%= a.getIdLiga() %>"><%= a.getNombre() %></option>
                        <% } } %>
                    </select>
                </div>
            </div>

            <div class="mb-4">
                <label for="txtModalidad" class="form-label fw-semibold">Modalidad</label>
                <input type="text" class="form-control" id="txtModalidad" name="modalidad" value="KUMITE" readonly>
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary px-4">Registrar</button>
                <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-outline-secondary">Volver al inicio</a>
            </div>
        </form>
    </section>

    <%-- Tabla de Karatecas registrados --%>
    <section>
        <h4 class="mb-3">Karatecas registrados</h4>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>DNI</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Sexo</th>
                        <th>Rango</th>
                        <th>Modalidad</th>
                        <th>Academia</th>
                    </tr>
                </thead>
                <tbody>
                <% if (karateca != null && !karateca.isEmpty()) {
                    for (Karateca a : karateca) { %>
                        <tr>
                            <td class="text-center"><%= a.getIdKarateca() %></td>
                            <td><%= a.getNombreCompleto() %></td>
                            <td><%= a.getDni() %></td>
                            <td><%= a.getEdad() %></td>
                            <td><%= a.getPeso() %></td>
                            <td><%= a.getSexo() %></td>
                            <td><%= a.getRango() %></td>
                            <td><%= a.getModalidad() %></td>
                            <td>
                                <%= obtenerNombreAcademia(a.getIdLiga(), academias) %>
                            </td>
                        </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="9" class="text-center text-muted">No hay karatecas registrados.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</div>

<!-- Bootstrap JS (para alertas y componentes interactivos) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
