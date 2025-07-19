<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>
<%
    String modo = (String) request.getAttribute("modo");
    Academia academia = (Academia) request.getAttribute("academia");
    boolean esEditar = "edit".equals(modo) && academia != null;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= esEditar ? "Editar Academia" : "Registrar Academia" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .form-card {
            border-radius: 1.5rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.07);
            padding: 2rem;
            background: #fff;
        }
        .btn-pill {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.3rem;
            padding-right: 1.3rem;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <h2 class="text-primary fw-bold mb-4 text-center">
                <%= esEditar ? "Editar Academia" : "Registrar Nueva Academia" %>
            </h2>
            <form action="academia" method="post" class="form-card">
                <input type="hidden" name="action" value="<%= esEditar ? "edit" : "new" %>">
                <% if (esEditar) { %>
                    <input type="hidden" name="id" value="<%= academia.getIdLiga() %>">
                <% } %>
                <div class="mb-3">
                    <label for="txtNombre" class="form-label fw-semibold">Nombre de la Academia</label>
                    <input type="text" class="form-control" id="txtNombre" name="nombre"
                           value="<%= esEditar ? academia.getNombre() : "" %>"
                           required maxlength="80">
                </div>
                <div class="mb-4">
                    <label for="txtRUC" class="form-label fw-semibold">RUC</label>
                    <input type="text" class="form-control" id="txtRUC" name="ruc"
                           value="<%= esEditar ? academia.getRuc() : "" %>"
                           required pattern="\d{11}" maxlength="11" minlength="11"
                           title="El RUC debe contar con 11 dígitos">
                </div>
                <div class="d-flex justify-content-between">
                    <a href="academia?action=listar" class="btn btn-secondary btn-pill">
                        <i class="bi bi-arrow-left"></i> Volver
                    </a>
                    <button type="submit" class="btn btn-success btn-pill">
                        <i class="bi <%= esEditar ? "bi-pencil-square" : "bi-plus-circle" %>"></i>
                        <%= esEditar ? "Guardar cambios" : "Registrar" %>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>