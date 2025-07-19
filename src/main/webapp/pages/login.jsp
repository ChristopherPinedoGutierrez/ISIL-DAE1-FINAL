<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ingreso de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .card-login {
            border-radius: 2rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.08);
        }
        .btn-pill {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.5rem;
            padding-right: 1.5rem;
        }
        .form-control {
            border-radius: 2rem !important;
        }
        .btn-volver {
            border-radius: 2rem !important;
            font-weight: 500;
            min-width: 160px;
            background: #212529;
            color: #fff;
            border: none;
        }
        .btn-volver:hover {
            background: #17191a;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center mb-3">
            <div class="col-md-5 d-flex align-items-center">
                <a href="index.jsp" class="btn btn-volver btn-pill shadow-sm me-2">
                    <i class="bi bi-arrow-left"></i> Volver al inicio
                </a>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card card-login shadow-sm border-0">
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
                            <button type="submit" class="btn btn-success btn-pill w-100">Ingresar</button>
                        </form>
                        <div class="mt-3 text-center">
                            ¿No tienes cuenta? <a href="usuario?action=register">Regístrate aquí</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>