<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ingreso de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background: #f5f7fa;">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <h3 class="fw-bold mb-4 text-primary text-center">Ingreso de Usuario</h3>
                        <% String error = (String) request.getAttribute("error");
                           String success = (String) request.getAttribute("success");
                           if (error != null) { %>
                            <div class="alert alert-danger"><%= error %></div>
                        <% } else if (success != null) { %>
                            <div class="alert alert-success"><%= success %></div>
                        <% } %>
                        <form action="login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <button type="submit" class="btn btn-success w-100">Ingresar</button>
                        </form>
                        <div class="mt-3 text-center">
                            ¿No tienes cuenta? <a href="Usuario?action=register">Regístrate aquí</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>