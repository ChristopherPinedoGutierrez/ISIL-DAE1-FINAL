<%@ page import="pe.isil.dae_01_pa4.model.beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    String action = request.getParameter("action");
    boolean isEdit = "edit".equals(action) && usuario != null;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= isEdit ? "Editar Usuario" : "Nuevo Usuario" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .card-form {
            border-radius: 2rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.06);
        }
        .btn-pill {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.5rem;
            padding-right: 1.5rem;
        }
        .btn-pill-cancel {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.2rem;
            padding-right: 1.2rem;
        }
        .form-control {
            border-radius: 2rem !important;
        }
    </style>
</head>
<body class="bg-light">
<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9">
            <div class="card card-form border-0 shadow-sm">
                <div class="card-body">
                    <h2 class="text-primary fw-bold mb-4 text-center">
                        <%= isEdit ? "Editar Usuario" : "Registrar Nuevo Usuario" %>
                    </h2>
                    <%-- Mensaje de éxito/error --%>
                    <%
                        String mensaje = (String) request.getAttribute("mensaje");
                        String tipoMensaje = (String) request.getAttribute("tipoMensaje"); // "success" o "danger"
                        if (mensaje != null) {
                    %>
                        <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info" %> alert-dismissible fade show" role="alert">
                            <%= mensaje %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>

                    <form method="post" action="usuario?action=save">
                        <% if (isEdit) { %>
                            <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>" />
                        <% } %>
                        <div class="row row-cols-1 row-cols-md-2 g-3">
                            <div class="col">
                                <div class="mb-3">
                                    <label for="username" class="form-label">Usuario</label>
                                    <input type="text" class="form-control" id="username" name="username" required
                                           value="<%= isEdit ? usuario.getUsername() : "" %>" />
                                </div>
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre completo</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" required
                                           value="<%= isEdit ? usuario.getNombre() : "" %>" />
                                </div>
                                <div class="mb-3">
                                    <label for="apellido" class="form-label">Apellido</label>
                                    <input type="text" class="form-control" id="apellido" name="apellido"
                                           value="<%= isEdit ? usuario.getApellido() : "" %>" required />
                                </div>
                            </div>
                            <div class="col">
                                <div class="mb-3">
                                    <label for="rol" class="form-label">Rol</label>
                                    <input type="text" class="form-control" id="rol" name="rol"
                                           value="<%= isEdit ? usuario.getRol() : "" %>" />
                                </div>
                                <div class="mb-3">
                                    <label for="dni" class="form-label">DNI</label>
                                    <input type="text" class="form-control" id="dni" name="dni"
                                           value="<%= isEdit ? usuario.getDni() : "" %>" />
                                </div>
                                <% if (!isEdit) { %>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="password" name="password" required />
                                </div>
                                <% } %>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between mt-4">
                            <a href="usuario?action=list" class="btn btn-secondary btn-pill-cancel">
                                <i class="bi bi-arrow-left"></i> Volver
                            </a>
                            <button type="submit" class="btn btn-success btn-pill">
                                <i class="bi <%= isEdit ? "bi-pencil-square" : "bi-plus-circle" %>"></i>
                                <%= isEdit ? "Guardar cambios" : "Registrar" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>