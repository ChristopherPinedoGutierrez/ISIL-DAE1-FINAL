<%@ page import="java.util.List" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .table thead th {
            background-color: #212529;
            color: #fff;
            vertical-align: middle;
            text-align: center;
        }
        .table tbody td {
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
<div class="container my-5">
    <h2 class="text-primary fw-bold mb-4 text-center">Gestión de Usuarios</h2>
    
    <!-- Barra de herramientas CRUD -->
    <div class="crud-toolbar">
        <!-- Botón Atrás a la izquierda -->
        <div>
            <a href="index.jsp" class="btn btn-dark btn-atras shadow-sm">
                <i class="bi bi-arrow-left"></i> Atrás
            </a>
        </div>
        <!-- Botones CRUD a la derecha -->
        <div class="btn-group btn-group-crud shadow-sm" role="group" aria-label="CRUD buttons">
            <a href="usuario?action=new" class="btn btn-success btn-crud">
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
    
    <div class="table-responsive rounded-4 shadow-sm">
        <table class="table table-bordered table-hover align-middle mb-0" id="tablaUsuarios">
            <thead class="table-dark text-center">
            <tr>
                <th style="width: 40px; text-align: center;">
                    <!-- Solo radio -->
                </th>
                <th>ID</th>
                <th>Usuario</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Rol</th>
                <th>DNI</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
                if (usuarios != null && !usuarios.isEmpty()) {
                    for (Usuario usuario : usuarios) {
            %>
                <tr>
                    <td style="text-align: center;">
                        <input type="radio" name="selectedUsuario" class="checkUsuario" value="<%= usuario.getIdUsuario() %>">
                    </td>
                    <td class="text-center"><%= usuario.getIdUsuario() %></td>
                    <td><%= usuario.getUsername() %></td>
                    <td><%= usuario.getNombre() %></td>
                    <td><%= usuario.getApellido() != null ? usuario.getApellido() : "" %></td>
                    <td class="text-center"><%= usuario.getRol() != null ? usuario.getRol() : "" %></td>
                    <td><%= usuario.getDni() != null ? usuario.getDni() : "" %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="7" class="text-center text-muted">No hay usuarios registrados.</td>
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
    // Selección de filas y habilitación de botones
    const btnEditar = document.getElementById('btnEditar');
    const btnEliminar = document.getElementById('btnEliminar');
    const tablaUsuarios = document.getElementById('tablaUsuarios');

    function updateCrudButtons() {
        const selected = tablaUsuarios.querySelector('.checkUsuario:checked');
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

    tablaUsuarios.addEventListener('change', function(event) {
        if (event.target.classList.contains('checkUsuario')) {
            updateCrudButtons();
        }
    });

    // Botón Editar: solo uno seleccionado
    btnEditar.addEventListener('click', function() {
        const selected = tablaUsuarios.querySelector('.checkUsuario:checked');
        if (selected) {
            const id = selected.value;
            window.location.href = 'usuario?action=edit&id=' + id;
        }
    });

    // Botón Eliminar: solo uno seleccionado
    btnEliminar.addEventListener('click', function() {
        const selected = tablaUsuarios.querySelector('.checkUsuario:checked');
        if (selected) {
            const id = selected.value;
            window.location.href = 'usuario?action=delete&id=' + id;
        }
    });

    // Inicializa el estado de los botones al cargar
    updateCrudButtons();
</script>
</body>
</html>