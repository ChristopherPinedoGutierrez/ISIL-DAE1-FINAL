<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Karateca" %>
<%@ page import="pe.isil.dae_01_pa4.model.beans.Llave" %>
<%@ page import="pe.isil.dae_01_pa4.business_logic.BL_Karateca" %>
<%
    Boolean generado = Boolean.TRUE.equals(request.getAttribute("generado"));
    List<Karateca> lista = (List<Karateca>) request.getAttribute("karatecasOrdenados");
    List<Llave> llaves = generado ? (List<Llave>) request.getAttribute("llaves") : null;
    Karateca campeon = generado ? (Karateca) request.getAttribute("campeon") : null;
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
    BL_Karateca blK = new BL_Karateca();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Llaves del Torneo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .table-responsive {
            border-radius: 1rem;
            box-shadow: 0 0.25rem 0.75rem rgba(0,0,0,0.05);
        }
        .btn-group-crud {
            width: 100%;
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        .btn-atras {
            padding-left: 1.2rem;
            padding-right: 1.2rem;
            border-radius: 2rem !important;
            font-weight: 500;
        }
        .btn-generar {
            border-radius: 2rem !important;
            font-weight: 500;
            padding-left: 1.4rem;
            padding-right: 1.4rem;
        }
        /* Cabecera roja solo para la primera tabla */
        .tabla-karatecas thead th {
            background-color: #dc3545;
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }
        /* Cabeceras normales para las otras tablas */
        .tabla-llaves thead th,
        .tabla-campeon thead th {
            background-color: #212529;
            color: #fff;
            text-align: center;
            vertical-align: middle;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <h2 class="text-danger fw-bold mb-4 text-center">Llaves del Torneo</h2>

    <% if (mensaje != null) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%= mensaje %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- Botones de navegación y acción -->
    <div class="btn-group-crud mb-4">
        <a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-dark btn-atras shadow-sm">
            <i class="bi bi-arrow-left"></i> Volver al inicio
        </a>
        <form action="<%=request.getContextPath()%>/llave" method="post" class="d-inline">
            <input type="hidden" name="action" value="generar">
            <button type="submit" class="btn btn-danger btn-generar shadow-sm">
                <i class="bi bi-play-circle"></i> Generar
            </button>
        </form>
    </div>

    <section>
        <h4 class="mb-3">Karatecas ordenados secuencialmente por edad, peso y rango</h4>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0 tabla-karatecas">
                <thead>
                    <tr>
                        <th>Nro</th>
                        <th>Nombre</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Rango</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int nro = 1;
                        if (lista != null) {
                            for (Karateca k : lista) {
                    %>
                        <tr>
                            <td><%= nro++ %></td>
                            <td><%= k.getNombreCompleto() %></td>
                            <td><%= k.getEdad() %></td>
                            <td><%= k.getPeso() %></td>
                            <td><%= k.getRango() %> kyu</td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>

    <%-- Mostrar la tabla de llaves generadas solo si se acaba de generar --%>
    <% if (generado && llaves != null && !llaves.isEmpty()) { %>
    <section class="mt-5">
        <h5 class="fw-semibold mb-3">Lista de Llaves Generadas</h5>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0 tabla-llaves">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Karateca 1</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Rango</th>
                        <th>Karateca 2</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Rango</th>
                        <th>Ronda</th>
                        <th>Ganador</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int contador = 1;
                        for (Llave l : llaves) {
                            Karateca k1 = blK.getById(l.getIdKarateca1());
                            Karateca k2 = blK.getById(l.getIdKarateca2());
                            Karateca ganadorK = l.getGanador() != null ? blK.getById(l.getGanador()) : null;
                            String nombreK1 = k1 != null ? k1.getNombreCompleto() : "Desconocido";
                            String nombreK2 = k2 != null ? k2.getNombreCompleto() : "Desconocido";
                            String rangoK1 = k1 != null ? (k1.getRango() + " kyu") : "";
                            String rangoK2 = k2 != null ? (k2.getRango() + " kyu") : "";
                            String ganadorStr = ganadorK != null ? ganadorK.getNombreCompleto() + " (" + ganadorK.getRango() + " kyu)" : "-";
                    %>
                    <tr>
                        <td class="text-center"><%= contador++ %></td>
                        <td><%= nombreK1 %></td>
                        <td><%= k1 != null ? k1.getEdad() : "" %></td>
                        <td><%= k1 != null ? k1.getPeso() : "" %></td>
                        <td><%= rangoK1 %></td>
                        <td><%= nombreK2 %></td>
                        <td><%= k2 != null ? k2.getEdad() : "" %></td>
                        <td><%= k2 != null ? k2.getPeso() : "" %></td>
                        <td><%= rangoK2 %></td>
                        <td class="text-center"><%= l.getRonda() %></td>
                        <td><%= ganadorStr %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </section>
    <% } %>

    <%-- Mostrar el campeón solo si se acaba de generar, con tabla y sin icono --%>
    <% if (generado && campeon != null) { %>
    <section class="mt-4">
        <h4 class="text-danger fw-bold mb-3 text-center">Campeón del Torneo</h4>
        <div class="table-responsive rounded-4 shadow-sm">
            <table class="table table-bordered table-hover align-middle mb-0 tabla-campeon">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>DNI</th>
                        <th>Edad</th>
                        <th>Peso</th>
                        <th>Sexo</th>
                        <th>Rango</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= campeon.getNombreCompleto() %></td>
                        <td><%= campeon.getDni() %></td>
                        <td><%= campeon.getEdad() %></td>
                        <td><%= campeon.getPeso() %></td>
                        <td><%= campeon.getSexo() %></td>
                        <td><%= campeon.getRango() %> kyu</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>
    <% } %>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>