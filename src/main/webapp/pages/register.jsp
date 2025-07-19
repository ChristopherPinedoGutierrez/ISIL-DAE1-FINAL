<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .card-register {
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
        .btn-registrar-control {
            max-width: 260px;
        }
        @media (max-width: 767px) {
            .row-cols-md-2 > .col {
                margin-bottom: 1rem;
            }
            .btn-registrar-control {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center mb-3">
            <div class="col-md-9 col-lg-8 d-flex align-items-center">
                <a href="index.jsp" class="btn btn-volver btn-pill shadow-sm me-2">
                    <i class="bi bi-arrow-left"></i> Volver al inicio
                </a>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-9 col-lg-8">
                <div class="card card-register shadow-sm border-0">
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
                        <form action="usuario?action=register" method="post" id="registerForm" autocomplete="off">
                            <div class="row row-cols-1 row-cols-md-2 g-3">
                                <div class="col">
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
                                </div>
                                <div class="col">
                                    <div class="mb-3">
                                        <label for="dni" class="form-label">DNI</label>
                                        <input type="text" class="form-control" id="dni" name="dni" required>
                                    </div>
                                    <input type="hidden" name="rol" value="usuario">
                                    <div class="mb-3">
                                        <label for="password" class="form-label">Contraseña</label>
                                        <input type="password" class="form-control" id="password" name="password" required autocomplete="new-password" 
                                            onfocus="this.type='password'" onblur="this.type='password'">
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirm_password" class="form-label">Repetir Contraseña</label>
                                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" required autocomplete="new-password"
                                            onfocus="this.type='password'" onblur="this.type='password'">
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-center">
                                <button type="submit" class="btn btn-primary btn-pill btn-registrar-control w-100 mt-2">
                                    Registrar
                                </button>
                            </div>
                        </form>
                        <div class="mt-3 text-center">
                            ¿Ya tienes cuenta? <a href="login">Ingresa aquí</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Validación frontend para contraseñas -->
    <script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        var pass = document.getElementById('password').value;
        var confirm = document.getElementById('confirm_password').value;
        if (pass !== confirm) {
            e.preventDefault();
            alert('Las contraseñas no coinciden');
        }
    });
    </script>
    <!-- Bootstrap Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>