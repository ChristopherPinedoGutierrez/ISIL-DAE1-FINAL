
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Torneo Nacional de Karate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            min-height: 100vh;
        }

        .card-hover:hover {
            transform: translateY(-5px);
            transition: all 0.3s ease;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.15);
        }

        .btn-custom {
            font-size: 1.1rem;
            padding: 12px 20px;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold text-primary">Gestión Torneo Nacional de Karate</h1>
            <p class="text-muted fs-5">Administra academias, registra karatecas y organiza el torneo fácilmente.</p>
        </div>

        <div class="row justify-content-center g-4">
            <div class="col-md-4">
                <div class="card card-hover shadow-sm border-0">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-semibold mb-3">Registrar Academias</h5>
                        <p class="card-text text-muted">Añade nuevas academias al sistema y gestiona sus datos.</p>
                        <a href="academia" class="btn btn-primary btn-custom w-100">Ir a Academias</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-hover shadow-sm border-0">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-semibold mb-3">Registrar Karatecas</h5>
                        <p class="card-text text-muted">Registra competidores con todos sus datos personales.</p>
                        <a href="karateca" class="btn btn-success btn-custom w-100">Ir a Karatecas</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-hover shadow-sm border-0">
                    <div class="card-body text-center">
                        <h5 class="card-title fw-semibold mb-3">Generar Llaves</h5>
                        <p class="card-text text-muted">Organiza automáticamente las rondas del torneo.</p>
                        <a href="llave" class="btn btn-danger btn-custom w-100">Generar Llaves</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


