
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
<div class="container py-4">

    <h2 class="mb-4">Registro de Academias</h2>

    <% if (mensaje != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= mensaje %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <form action="<%=request.getContextPath()%>/academia" method="post" class="card p-4 mb-4 shadow-sm">
        <input type="hidden" name="action" value="registrar">
        <div class="mb-3">
            <label for="txtNombre" class="form-label">Nombre de la Academia</label>
            <input type="text" class="form-control" id="txtNombre" name="nombre" required>
        </div>
        <div class="mb-3">
            <label for="txtRUC" class="form-label">RUC</label>
            <input type="text" class="form-control" id="txtRUC" name="ruc" required maxlength="11">
        </div>
        <button type="submit" class="btn btn-primary">Registrar</button>
        <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-secondary">Volver al inicio</a>
    </form>

    <h4 class="mb-3">Academias Registradas</h4>
    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
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
                    <td><%= a.getIdLiga() %></td>
                    <td><%= a.getNombre() %></td>
                    <td><%= a.getRuc() %></td>
                </tr>
            <% } } else { %>
                <tr>
                    <td colspan="3" class="text-center">No hay academias registradas.</td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
