<%@ page import="pe.isil.dae_01_pa4.model.beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Torneo Nacional de Karate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
            font-size: 1.05rem;
            padding: 8px 14px;
        }
        .navbar .navbar-nav .nav-item {
            margin-left: 10px;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center">

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    // Variables para botones principales
    String academiaBtnClass, karatecaBtnClass, llaveBtnClass;
    String academiaBtnDisabled, karatecaBtnDisabled, llaveBtnDisabled;
    String academiaTooltip, karatecaTooltip, llaveTooltip;

    if (usuario == null) {
        academiaBtnClass = "btn btn-secondary btn-custom w-100 mt-3";
        karatecaBtnClass = "btn btn-secondary btn-custom w-100 mt-3";
        llaveBtnClass = "btn btn-secondary btn-custom w-100 mt-3";
        academiaBtnDisabled = "disabled";
        karatecaBtnDisabled = "disabled";
        llaveBtnDisabled = "disabled";
        academiaTooltip = "title='Debes iniciar sesión' data-bs-toggle='tooltip' data-bs-placement='bottom'";
        karatecaTooltip = "title='Debes iniciar sesión' data-bs-toggle='tooltip' data-bs-placement='bottom'";
        llaveTooltip = "title='Debes iniciar sesión' data-bs-toggle='tooltip' data-bs-placement='bottom'";
    } else {
        academiaBtnClass = "btn btn-primary btn-custom w-100 mt-3";
        karatecaBtnClass = "btn btn-success btn-custom w-100 mt-3";
        llaveBtnClass = "btn btn-danger btn-custom w-100 mt-3";
        academiaBtnDisabled = "";
        karatecaBtnDisabled = "";
        llaveBtnDisabled = "";
        academiaTooltip = "";
        karatecaTooltip = "";
        llaveTooltip = "";
    }
%>

<!-- Navbar dinámica -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm position-fixed w-100" style="top:0;left:0;z-index:1050;">
    <div class="container">
        <a class="navbar-brand text-primary fw-bold" href="index.jsp">DAE 1 - Proyecto Final</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-center">
                <% if (usuario != null) { %>
                    <li class="nav-item">
                        <a class="btn btn-outline-primary btn-sm btn-custom" href="usuario?action=list">
                            <i class="bi bi-people"></i> Gestionar Usuarios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-danger btn-sm btn-custom" href="login?action=logout">
                            <i class="bi bi-box-arrow-right"></i> Cerrar sesión
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="btn btn-outline-primary btn-sm btn-custom" href="usuario?action=register">
                            <i class="bi bi-person-plus"></i> Registrar
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-success btn-sm btn-custom" href="login">
                            <i class="bi bi-box-arrow-in-right"></i> Ingresar
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Espacio para navbar fijo -->
<div style="height:70px;"></div>

<!-- Mensajes globales -->
<%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    if (error != null) {
%>
    <div class="container mt-3">
        <div class="alert alert-danger text-center"><%= error %></div>
    </div>
<% } else if (success != null) { %>
    <div class="container mt-3">
        <div class="alert alert-success text-center"><%= success %></div>
    </div>
<% } %>

<div class="container py-5">
    <div class="text-center mb-5">
        <h1 class="fw-bold text-primary">Gestión Torneo Nacional de Karate</h1>
        <p class="text-muted fs-5">Administra academias, registra karatecas y organiza el torneo fácilmente.</p>
    </div>
    
    <div class="row justify-content-center g-4">
        <div class="col-md-4">
            <div class="card card-hover shadow-sm border-0 h-100">
                <div class="card-body d-flex flex-column justify-content-between text-center h-100">
                    <div>
                        <h5 class="card-title fw-semibold mb-3">Registrar Academias</h5>
                        <p class="card-text text-muted">Añade nuevas academias al sistema y gestiona sus datos.</p>
                    </div>
                    <% if (usuario == null) { %>
                        <button class="btn btn-secondary btn-custom w-100 mt-3" disabled
                            title="Debes iniciar sesión" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            Ir a Academias
                        </button>
                    <% } else { %>
                    <a href="academia?action=listar" class="btn btn-primary btn-custom w-100 mt-3">
                            Ir a Academias
                        </a>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover shadow-sm border-0 h-100">
                <div class="card-body d-flex flex-column justify-content-between text-center h-100">
                    <div>
                        <h5 class="card-title fw-semibold mb-3">Registrar Karatecas</h5>
                        <p class="card-text text-muted">Registra competidores con todos sus datos personales.</p>
                    </div>
                    <% if (usuario == null) { %>
                        <button class="btn btn-secondary btn-custom w-100 mt-3" disabled
                            title="Debes iniciar sesión" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            Ir a Karatecas
                        </button>
                    <% } else { %>
                        <a href="karateca" class="btn btn-success btn-custom w-100 mt-3">
                            Ir a Karatecas
                        </a>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-hover shadow-sm border-0 h-100">
                <div class="card-body d-flex flex-column justify-content-between text-center h-100">
                    <div>
                        <h5 class="card-title fw-semibold mb-3">Generar Llaves</h5>
                        <p class="card-text text-muted">Organiza automáticamente las rondas del torneo.</p>
                    </div>
                    <% if (usuario == null) { %>
                        <button class="btn btn-secondary btn-custom w-100 mt-3" disabled
                            title="Debes iniciar sesión" data-bs-toggle="tooltip" data-bs-placement="bottom">
                            Generar Llaves
                        </button>
                    <% } else { %>
                        <a href="llave" class="btn btn-danger btn-custom w-100 mt-3">
                            Generar Llaves
                        </a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and tooltip activation -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });
});
</script>
</body>
</html>