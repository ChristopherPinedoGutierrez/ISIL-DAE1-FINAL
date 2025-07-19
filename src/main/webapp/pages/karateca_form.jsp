<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Karateca" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>
<%
    Karateca karateca = (Karateca) request.getAttribute("karateca");
    ArrayList<Academia> academias = (ArrayList<Academia>) request.getAttribute("academias");
    String modo = (String) request.getAttribute("modo");
    boolean editar = "edit".equals(modo);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= editar ? "Editar Karateca" : "Registrar Karateca" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .card-form {
            border-radius: 2rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.07);
            max-width: 650px;
            margin: 0 auto;
        }
        .form-control, .form-select {
            border-radius: 2rem !important;
        }
        .btn-pill {
            border-radius: 2rem !important;
            font-weight: 500;
        }
        .btn-atras {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.3rem;
            padding-right: 1.3rem;
        }
        .btn-guardar {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 2rem;
            padding-right: 2rem;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="card card-form shadow border-0">
        <div class="card-body">
            <h2 class="text-success fw-bold mb-4 text-center">
                <%= editar ? "Editar Karateca" : "Registrar Nuevo Karateca" %>
            </h2>
            <form action="karateca" method="post" autocomplete="off">
                <input type="hidden" name="action" value="<%= editar ? "edit" : "new" %>">
                <% if (editar) { %>
                    <input type="hidden" name="id" value="<%= karateca != null ? karateca.getIdKarateca() : "" %>">
                <% } %>
                <div class="mb-3">
                    <label for="txtNombre" class="form-label fw-semibold">Nombre completo</label>
                    <input type="text" class="form-control" id="txtNombre" name="nombre_completo" required
                        value="<%= karateca != null ? karateca.getNombreCompleto() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="txtDNI" class="form-label fw-semibold">DNI</label>
                    <input type="text" class="form-control" id="txtDNI" name="dni" required maxlength="8" pattern="[0-9]{8}" title="Debe ingresar 8 dígitos"
                        value="<%= karateca != null ? karateca.getDni() : "" %>">
                </div>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="txtEdad" class="form-label fw-semibold">Edad</label>
                        <input type="number" class="form-control" id="txtEdad" name="edad" required min="0"
                            value="<%= karateca != null ? karateca.getEdad() : "" %>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="txtPeso" class="form-label fw-semibold">Peso (kg)</label>
                        <input type="number" class="form-control" id="txtPeso" name="peso" required min="0" step="0.01"
                            value="<%= karateca != null ? karateca.getPeso() : "" %>">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="txtSexo" class="form-label fw-semibold">Sexo</label>
                        <select class="form-select" id="txtSexo" name="sexo" required>
                            <option value="">Selecciona...</option>
                            <option value="M" <%= karateca != null && "M".equals(karateca.getSexo()) ? "selected" : "" %>>Masculino</option>
                            <option value="F" <%= karateca != null && "F".equals(karateca.getSexo()) ? "selected" : "" %>>Femenino</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="txtRango" class="form-label fw-semibold">Rango</label>
                        <input type="number" class="form-control" id="txtRango" name="rango" required min="0" max="10"
                            value="<%= karateca != null ? karateca.getRango() : "" %>">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="txtAcademia" class="form-label fw-semibold">Academia</label>
                        <select class="form-select" id="txtAcademia" name="id_liga" required>
                            <option value="">Selecciona...</option>
                            <% if (academias != null) {
                                for (Academia a : academias) { %>
                                    <option value="<%= a.getIdLiga() %>" <%= karateca != null && a.getIdLiga() == karateca.getIdLiga() ? "selected" : "" %>><%= a.getNombre() %></option>
                            <% } } %>
                        </select>
                    </div>
                </div>
                <input type="hidden" name="modalidad" value="KUMITE">
                <div class="mt-4 d-flex justify-content-between">
                    <a href="karateca?action=listar" class="btn btn-secondary btn-atras shadow-sm">
                        <i class="bi bi-arrow-left"></i> Volver
                    </a>
                    <button type="submit" class="btn btn-success btn-guardar shadow-sm">
                        <i class="bi <%= editar ? "bi-pencil-square" : "bi-person-plus" %>"></i>
                        <%= editar ? "Guardar cambios" : "Registrar" %>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>