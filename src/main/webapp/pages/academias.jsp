<%@ page import="java.util.List" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Academia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Academias</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .table thead th {
            background-color: #212529;
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
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="text-primary fw-bold mb-4 text-center">Gestión de Academias</h2>

    <% String mensaje = (String) request.getAttribute("mensaje"); %>
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
            <a href="academia?action=new" class="btn btn-success btn-crud">
                <i class="bi bi-plus-circle"></i> Agregar
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
    <form id="formEliminarAcademia" method="post" action="academia" style="display:none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="inputEliminarId">
    </form>

    <div class="table-responsive rounded-4 shadow-sm">
        <table class="table table-bordered table-hover align-middle mb-0" id="tablaAcademias">
            <thead class="table-dark text-center">
            <tr>
                <th style="width: 40px; text-align: center;"></th>
                <th>ID</th>
                <th>Nombre</th>
                <th>RUC</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Academia> academias = (List<Academia>) request.getAttribute("academias");
                if (academias != null && !academias.isEmpty()) {
                    for (Academia a : academias) {
            %>
                <tr>
                    <td style="text-align: center;">
                        <input type="radio" name="selectedAcademia" class="checkAcademia" value="<%= a.getIdLiga() %>">
                    </td>
                    <td class="text-center"><%= a.getIdLiga() %></td>
                    <td><%= a.getNombre() %></td>
                    <td><%= a.getRuc() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="4" class="text-center text-muted">No hay academias registradas.</td>
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
    const tablaAcademias = document.getElementById('tablaAcademias');

    function updateCrudButtons() {
        const selected = tablaAcademias.querySelector('.checkAcademia:checked');
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

    tablaAcademias.addEventListener('change', function(event) {
        if (event.target.classList.contains('checkAcademia')) {
            updateCrudButtons();
        }
    });

    btnEditar.addEventListener('click', function() {
        const selected = tablaAcademias.querySelector('.checkAcademia:checked');
        if (selected) {
            const id = selected.value;
            window.location.href = 'academia?action=edit&id=' + id;
        }
    });

    // Eliminar por POST usando formulario oculto
    btnEliminar.addEventListener('click', function() {
        const selected = tablaAcademias.querySelector('.checkAcademia:checked');
        if (selected) {
            document.getElementById('inputEliminarId').value = selected.value;
            document.getElementById('formEliminarAcademia').submit();
        }
    });

    updateCrudButtons();
</script>
</body>
</html>