# Gestión de Clientes - Flutter App

Esta aplicación de gestión de clientes está desarrollada en Flutter y ofrece funcionalidades completas para registrar, editar, eliminar y buscar clientes. Utiliza una arquitectura limpia para garantizar que el código sea modular, escalable y fácil de mantener.

Video de demostración en YouTube: [https://youtu.be/IS2PlE-aSAg]

## Características

- **Registro de usuarios**: Permite añadir e iniciar sesion con cada usuario, ademas de crear clientes.
- **Registro y consulta de clientes**: Permite añadir y ver la información detallada de cada cliente.
- **Edición y eliminación de clientes**: Actualiza y elimina datos de los clientes de forma sencilla.
- **Autenticación segura**: Incluye inicio y cierre de sesión con almacenamiento seguro de credenciales.
- **Navegación**: Implementada con GoRouter para mantener una navegación fluida y organizada.
- **Búsqueda**: Permite buscar clientes cargados en la lista, optimizando el rendimiento.

## Tecnologías y Librerías

- **Flutter**: Framework para la construcción de la app.
- **Riverpod**: Gestión de estado eficiente y reactiva.
- **GoRouter**: Navegación estructurada y escalable.
- **Flutter Secure Storage**: Almacenamiento seguro de credenciales y datos sensibles.

## Configuración del Proyecto

Para configurar y ejecutar el proyecto, sigue los pasos a continuación.

### 1. Crear el archivo `.env`

Este proyecto utiliza un archivo `.env` para gestionar configuraciones sensibles, como las URLs de APIs y credenciales. Asegúrate de crear el archivo `.env` en la raíz del proyecto. El archivo `.env` debe contener las siguientes variables:

```plaintext
BASE_URL=
TOKEN_VALUE=
```


## Arquitectura del Proyecto

La aplicación sigue una arquitectura limpia y está organizada en tres capas principales:

### Presentación:
Incluye todos los widgets de la interfaz de usuario y la lógica de presentación.

### Dominio:
Contiene las entidades y casos de uso de la aplicación.

### Infraestructura:
 Maneja las implementaciones de repositorios y las interacciones con servicios externos

