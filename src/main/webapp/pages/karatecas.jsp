<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Karateca" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>

<%
    ArrayList<Karateca> karateca = (ArrayList<Karateca>) request.getAttribute("listaKaratecas");
    ArrayList<Academia> academias = (ArrayList<Academia>) request.getAttribute("listaAcademias");
    String mensaje = (String) request.getAttribute("mensaje");
%>
<%!
    String obtenerNombreAcademia(int idLiga, ArrayList<Academia> academias) {
        if (academias != null) {
            for (Academia a : academias) {
                if (a.getIdLiga() == idLiga) {
                    return a.getNombre();
                }
            }
        }
        return "Sin academia";
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Karatecas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .table thead th {
            background-color: #198754; /* verde Bootstrap */
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }
        .table-responsive {
            border-radius: 1rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.05);
        }
        .crud-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }
        .btn-group-crud {
            overflow: hidden;
            border-radius: 2rem;
            box-shadow: 0 0.15rem 0.45rem rgba(0,0,0,0.08);
            display: inline-flex;
        }
        .btn-group-crud .btn {
            border-radius: 0 !important;
        }
        .btn-group-crud .btn:first-child {
            border-top-left-radius: 2rem !important;
            border-bottom-left-radius: 2rem !important;
        }
        .btn-group-crud .btn:last-child {
            border-top-right-radius: 2rem !important;
            border-bottom-right-radius: 2rem !important;
        }
        .btn-atras {
            padding-left: 1.2rem;
            padding-right: 1.2rem;
            border-radius: 2rem !important;
            font-weight: 500;
        }
        .titulo-verde {
            color: #198754 !important;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="titulo-verde fw-bold mb-4 text-center">Gestión de Karatecas</h2>

    <% if (mensaje != null) { %>
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <%= mensaje %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- Barra de herramientas CRUD -->
    <div class="crud-toolbar">
        <a href="index.jsp" class="btn btn-dark btn-atras shadow-sm">
            <i class="bi bi-arrow-left"></i> Atrás
        </a>
        <div class="btn-group btn-group-crud shadow-sm" role="group" aria-label="CRUD buttons">
            <a href="karateca?action=new" class="btn btn-success btn-crud">
                <i class="bi bi-person-plus"></i> Agregar
            </a>
            <button id="btnEditar" class="btn btn-primary btn-crud" disabled>
                <i class="bi bi-pencil-square"></i> Editar
            </button>
            <button id="btnEliminar" class="btn btn-danger btn-crud" disabled>
                <i class="bi bi-trash"></i> Eliminar
            </button>
        </div>
    </div>

    <!-- Formulario oculto para eliminar por POST -->
    <form id="formEliminarKarateca" method="post" action="karateca" style="display:none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="inputEliminarIdKarateca">
    </form>

    <div class="table-responsive rounded-4 shadow-sm">
        <table class="table table-bordered table-hover align-middle mb-0" id="tablaKaratecas">
            <thead>
            <tr>
                <th style="width: 40px; text-align: center;"></th>
                <th>ID</th>
                <th>Nombre</th>
                <th>DNI</th>
                <th>Edad</th>
                <th>Peso</th>
                <th>Sexo</th>
                <th>Rango</th>
                <th>Academia</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (karateca != null && !karateca.isEmpty()) {
                    for (Karateca k : karateca) {
            %>
                <tr>
                    <td style="text-align: center;">
                        <input type="radio" name="selectedKarateca" class="checkKarateca" value="<%= k.getIdKarateca() %>">
                    </td>
                    <td class="text-center"><%= k.getIdKarateca() %></td>
                    <td><%= k.getNombreCompleto() %></td>
                    <td><%= k.getDni() %></td>
                    <td><%= k.getEdad() %></td>
                    <td><%= k.getPeso() %></td>
                    <td><%= k.getSexo() %></td>
                    <td><%= k.getRango() %> kyu</td>
                    <td><%= obtenerNombreAcademia(k.getIdLiga(), academias) %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="9" class="text-center text-muted">No hay karatecas registrados.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const btnEditar = document.getElementById('btnEditar');
    const btnEliminar = document.getElementById('btnEliminar');
    const tablaKaratecas = document.getElementById('tablaKaratecas');

    function updateCrudButtons() {
        const selected = tablaKaratecas.querySelector('.checkKarateca:checked');
        btnEditar.disabled = !selected;
        btnEliminar.disabled = !selected;
        if (!selected) {
            btnEditar.classList.add('btn-secondary', 'disabled');
            btnEditar.classList.remove('btn-primary');
            btnEliminar.classList.add('btn-secondary', 'disabled');
            btnEliminar.classList.remove('btn-danger');
        } else {
            btnEditar.classList.remove('btn-secondary', 'disabled');
            btnEditar.classList.add('btn-primary');
            btnEliminar.classList.remove('btn-secondary', 'disabled');
            btnEliminar.classList.add('btn-danger');
        }
    }

    tablaKaratecas.addEventListener('change', function(event) {
        if (event.target.classList.contains('checkKarateca')) {
            updateCrudButtons();
        }
    });

    btnEditar.addEventListener('click', function() {
        const selected = tablaKaratecas.querySelector('.checkKarateca:checked');
        if (selected) {
            const id = selected.value;
            window.location.href = 'karateca?action=edit&id=' + id;
        }
    });

    // Eliminar por POST usando formulario oculto
    btnEliminar.addEventListener('click', function() {
        const selected = tablaKaratecas.querySelector('.checkKarateca:checked');
        if (selected) {
            document.getElementById('inputEliminarIdKarateca').value = selected.value;
            document.getElementById('formEliminarKarateca').submit();
        }
    });

    updateCrudButtons();
</script>
</body>
</html>