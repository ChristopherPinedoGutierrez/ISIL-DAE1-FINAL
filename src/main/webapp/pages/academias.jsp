<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>
<%
    ArrayList<Academia> academias = (ArrayList<Academia>) request.getAttribute("listaAcademias");
    String mensaje = (String) request.getAttribute("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Academias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <section class="mb-5">
        <h2 class="text-primary mb-4">Registro de Academias</h2>

        <% if (mensaje != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= mensaje %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <form action="<%=request.getContextPath()%>/academia" method="post" class="card shadow rounded-4 p-4 mb-4 bg-white border-0">
            <input type="hidden" name="action" value="registrar">

            <div class="mb-3">
                <label for="txtNombre" class="form-label fw-semibold">Nombre de la Academia</label>
                <input type="text" class="form-control" id="txtNombre" name="nombre" required>
            </div>

            <div class="mb-4">
                <label for="txtRUC" class="form-label fw-semibold">RUC</label>
                <input type="text" class="form-control" id="txtRUC" name="ruc" required
                       pattern="\d{11}" maxlength="11" minlength="11"
                       title="El RUC debe contar con 11 dígitos">
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary px-4">Registrar</button>
                <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-outline-secondary">Volver al inicio</a>
            </div>
        </form>
    </section>

    <section>
        <h4 class="mb-3">Academias Registradas</h4>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0">
                <thead class="table-dark text-center">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>RUC</th>
                </tr>
                </thead>
                <tbody>
                <% if (academias != null && !academias.isEmpty()) {
                    for (Academia a : academias) { %>
                        <tr>
                            <td class="text-center"><%= a.getIdLiga() %></td>
                            <td><%= a.getNombre() %></td>
                            <td><%= a.getRuc() %></td>
                        </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="3" class="text-center text-muted">No hay academias registradas.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
