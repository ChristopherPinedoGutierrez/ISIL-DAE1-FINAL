<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background: #f5f7fa;">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <h3 class="fw-bold mb-4 text-primary text-center">Registro de Usuario</h3>
                        <% String error = (String) request.getAttribute("error");
                           String success = (String) request.getAttribute("success");
                           String mensaje = (String) request.getAttribute("mensaje");
                           String tipoMensaje = (String) request.getAttribute("tipoMensaje");
                           if (error != null) { %>
                            <div class="alert alert-danger"><%= error %></div>
                        <% } else if (success != null) { %>
                            <div class="alert alert-success"><%= success %></div>
                        <% } else if (mensaje != null) { %>
                            <div class="alert alert-<%= tipoMensaje != null ? tipoMensaje : "info" %>"><%= mensaje %></div>
                        <% } %>
                        <form action="Usuario?action=register" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" name="nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" name="apellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="dni" class="form-label">DNI</label>
                                <input type="text" class="form-control" id="dni" name="dni" required>
                            </div>
                            <input type="hidden" name="rol" value="usuario">
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Registrar</button>
                        </form>
                        <div class="mt-3 text-center">
                            ¿Ya tienes cuenta? <a href="login">Ingresa aquí</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>