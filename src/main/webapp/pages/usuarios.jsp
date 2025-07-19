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
            background-color: #f6f9fc;
            vertical-align: middle;
        }
        .btn-group-crud {
            margin-bottom: 18px;
        }
        .crud-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <h2 class="text-primary fw-bold mb-4 text-center">Gestión de Usuarios</h2>
    
    <!-- Barra de herramientas CRUD -->
    <div class="crud-toolbar">
        <!-- Botón Atrás a la izquierda -->
        <div>
            <a href="index.jsp" class="btn btn-dark">
                <i class="bi bi-arrow-left"></i> Atrás
            </a>
        </div>
        <!-- Botones CRUD a la derecha -->
        <div class="btn-group btn-group-crud" role="group" aria-label="CRUD buttons">
            <a href="Usuario?action=new" class="btn btn-success">
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
    
    <div class="table-responsive">
        <table class="table table-bordered align-middle" id="tablaUsuarios">
            <thead>
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
                    <td><%= usuario.getIdUsuario() %></td>
                    <td><%= usuario.getUsername() %></td>
                    <td><%= usuario.getNombre() %></td>
                    <td><%= usuario.getApellido() != null ? usuario.getApellido() : "" %></td>
                    <td><%= usuario.getRol() != null ? usuario.getRol() : "" %></td>
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
            window.location.href = 'Usuario?action=edit&id=' + id;
        }
    });

    // Botón Eliminar: solo uno seleccionado
    btnEliminar.addEventListener('click', function() {
        const selected = tablaUsuarios.querySelector('.checkUsuario:checked');
        if (selected) {
            const id = selected.value;
            window.location.href = 'Usuario?action=delete&id=' + id;
        }
    });

    // Inicializa el estado de los botones al cargar
    updateCrudButtons();
</script>
</body>
</html>