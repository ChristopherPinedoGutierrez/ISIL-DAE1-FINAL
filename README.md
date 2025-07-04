# Sistema de Llaves para Torneo de Karate

Este proyecto es una aplicación web desarrollada en Java para la gestión y generación de llaves de torneos de karate. Permite registrar karatecas, ordenarlos según criterios deportivos y generar las llaves del torneo de manera automática, mostrando el avance de rondas hasta definir al campeón.

## Tecnologías Utilizadas

- **Java EE (Servlets y JSP):** Lógica de negocio y presentación web.
- **JSP (JavaServer Pages):** Generación dinámica de páginas HTML.
- **Servlets:** Controladores para la gestión de solicitudes HTTP y flujo de la aplicación.
- **JDBC:** Acceso y manipulación de datos en la base de datos relacional.
- **Bootstrap 5:** Estilos y componentes responsivos para la interfaz de usuario.
- **MVC (Modelo-Vista-Controlador):** Separación de la lógica de negocio, presentación y acceso a datos.
- **DAO (Data Access Object):** Patrón para el acceso a datos de entidades como Karateca, Llave y Academia.

## Funcionalidades Principales

- **Registro y consulta de Karatecas:** Almacenamiento y listado de participantes con sus datos personales y deportivos.
- **Ordenamiento de Karatecas:** Los participantes se ordenan secuencialmente por edad, peso y rango para una distribución justa en las llaves.
- **Generación automática de Llaves:** Creación de las rondas del torneo, emparejando karatecas y avanzando ganadores automáticamente.
- **Visualización de rondas y campeón:** Tablas detalladas de los enfrentamientos generados y presentación del campeón tras finalizar el torneo.
- **Interfaz amigable:** Uso de tablas, alertas y botones estilizados con Bootstrap para facilitar la interacción.

## Técnicas y Buenas Prácticas Aplicadas

- **Separación de responsabilidades:** Lógica de negocio desacoplada de la vista y del acceso a datos.
- **Uso de beans Java:** Definición de clases modelo (`Karateca`, `Llave`, `Academia`) para transportar y manipular datos.
- **Reutilización de código en JSP:** Métodos auxiliares para mostrar información relacionada (ej: nombre de academia).
- **Mensajes de usuario claros:** Uso de alertas Bootstrap para informar acciones exitosas o errores.
- **Control de flujo con Servlets:** Gestión eficiente de los forwards y atributos para mantener el estado de la aplicación.
- **Validación y manejo de errores:** Control de casos como ausencia de llaves o de campeón.

## Estructura Principal de Archivos

- `/src/main/java/pe/isil/dae_01_pa4/model/beans/` — Clases modelo (Karateca, Llave, Academia).
- `/src/main/java/pe/isil/dae_01_pa4/business_logic/` — Lógica de negocio y DAOs.
- `/src/main/webapp/pages/llaves.jsp` — Vista principal de gestión de llaves.
- `/src/main/java/pe/isil/dae_01_pa4/controller/LlaveController.java` — Controlador principal de llaves.

## Cómo Utilizar

1. **Registrar karatecas:** Utiliza la sección correspondiente para registrar nuevos participantes.
2. **Visualizar y ordenar:** Accede a la sección de llaves para ver a los karatecas ordenados y listos para el torneo.
3. **Generar llaves:** Haz clic en "Generar" para crear los enfrentamientos y visualizar las rondas.
4. **Visualizar campeón:** Una vez finalizado el torneo, se mostrará el campeón en la sección correspondiente.

---

**Desarrollado por:** Christopher Pinedo Gutiérrez  
**ISIL - Desarrollo de Aplicaciones Empresariales**