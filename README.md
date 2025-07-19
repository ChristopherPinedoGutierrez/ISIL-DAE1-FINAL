# Sistema de Llaves para Torneo de Karate

Este proyecto es una aplicación web desarrollada en Java para la gestión y generación de llaves de torneos de karate. Permite registrar karatecas, ordenarlos según criterios deportivos y generar las llaves del torneo de manera automática, mostrando el avance de rondas hasta definir al campeón.

## Tecnologías Utilizadas

- **Java EE (Servlets y JSP):** Implementa la lógica de negocio y la presentación web.
- **JSP (JavaServer Pages):** Generación dinámica de páginas HTML para vistas y formularios.
- **Servlets:** Controladores para la gestión de solicitudes HTTP y flujo de la aplicación.
- **JDBC:** Acceso y manipulación de datos en la base de datos relacional (MySQL u otra compatible).
- **Bootstrap 5:** Componentes responsivos para la interfaz de usuario.
- **MVC (Modelo-Vista-Controlador):** Separación de lógica, presentación y acceso a datos.
- **DAO (Data Access Object):** Patrón para la gestión de entidades persistentes.
- **Beans Java:** Clases modelo para transportar datos (`Karateca`, `Llave`, `Academia`).

## Funcionalidades Principales

- **Registro y consulta de Karatecas:** Almacenamiento y listado de participantes con sus datos personales y deportivos.  
  Formulario de registro y edición, listado y eliminación.
- **Gestión de Academias:** Alta, edición, consulta y eliminación de academias.  
  Asociación de karatecas a academias.
- **Autenticación de usuarios:** Registro, login y control de sesión para acceso seguro a funcionalidades.
- **Ordenamiento de Karatecas:** Orden secuencial por edad, peso y rango antes de generar las llaves.
- **Generación automática de Llaves:** Crea las rondas del torneo, empareja karatecas y avanza ganadores automáticamente.
- **Visualización de rondas y campeón:** Tablas detalladas de los enfrentamientos y presentación del campeón tras finalizar el torneo.
- **Manejo de mensajes y errores:** Alertas informativas y mensajes claros para el usuario.

## Técnicas y Detalles Técnicos

- **Separación de responsabilidades:**  
  Lógica de negocio desacoplada de la vista (JSP) y del acceso a datos (DAO).
- **Control de flujo:**  
  Uso de servlets para forwards/redirecciones y atributos de sesión/request para mantener el estado de la aplicación.
- **Validación de datos:**  
  Validación de formularios en backend y frontend; manejo de errores y casos límite (sin karatecas, sin llaves, etc.).
- **Estructura de entidades:**  
  Beans Java para entidades principales, con métodos auxiliares y constructores.
- **Gestión de base de datos:**  
  Acceso mediante JDBC, uso de DAOs para operaciones CRUD.

## Estructura Principal de Archivos

- `/src/main/java/pe/isil/dae_01_pa4/model/beans/` — Clases modelo (Karateca, Llave, Academia, Usuario).
- `/src/main/java/pe/isil/dae_01_pa4/business_logic/` — Lógica de negocio y DAOs.
- `/src/main/java/pe/isil/dae_01_pa4/controller/` — Servlets controladores por entidad (LlaveController, KaratecaController, AcademiaController, UsuarioController).
- `/src/main/webapp/pages/` — Vistas JSP para cada funcionalidad (listados, formularios, llaves, campeón).
- `/src/main/webapp/index.jsp` — Página principal de navegación.

## Cómo Utilizar

1. **Registrar karatecas y academias:** Utiliza las secciones correspondientes para registrar nuevos participantes y academias.
2. **Gestionar usuarios:** Regístrate e inicia sesión para acceder a todas las funcionalidades.
3. **Visualizar y ordenar:** Accede a la sección de llaves para ver karatecas ordenados y listos para el torneo.
4. **Generar llaves:** Haz clic en "Generar" para crear los emparejamientos y visualizar las rondas.
5. **Visualizar campeón:** Al finalizar el torneo, se muestra el campeón en la sección correspondiente.

---

**Desarrollado por:** Christopher Pinedo Gutiérrez  
**ISIL - Desarrollo de Aplicaciones Empresariales 1**