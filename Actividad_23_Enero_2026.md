# Actividad - 23 Enero 2026  
## Desarrollo de App Ecommerce con Navegación Profesional (8 Pantallas)

## Objetivo del Ejercicio
Desarrollar una aplicación móvil tipo **Ecommerce** en **Flutter** que contenga:

- **8 pantallas**
- Navegación fluida
- Retorno correcto entre pantallas
- Transiciones animadas
- Diseño básico con **Material UI**
- **Arquitectura limpia**

---

## Flujo de Navegación
**Splash → Login → Home → Categorías → Productos → Detalle Producto → Carrito → Checkout**

---

## Estructura del Proyecto
```txt
lib/
├─ main.dart
├─ routes/
│  └─ custom_routes.dart
└─ screens/
   ├─ splash_screen.dart
   ├─ login_screen.dart
   ├─ home_screen.dart
   ├─ categories_screen.dart
   ├─ products_screen.dart
   ├─ product_detail_screen.dart
   ├─ cart_screen.dart
   └─ checkout_screen.dart
```

---

## Pantallas a Construir

| # | Pantalla | Función |
|---|----------|---------|
| 1 | Splash | Presentación inicial |
| 2 | Login | Acceso de usuario |
| 3 | Home | Inicio del ecommerce |
| 4 | Categorías | Listado de categorías |
| 5 | Productos | Listado de productos |
| 6 | Detalle Producto | Información del producto |
| 7 | Carrito | Productos agregados |
| 8 | Checkout | Finalizar compra |

---

## Diseño Requerido
Cada pantalla debe incluir:

- **AppBar** con título
- Íconos representativos
- Botones de navegación
- **Cards** para productos
- Colores corporativos
- Diseño **responsive**

---

## Navegación Requerida
Debe implementarse usando:

- `Navigator.push()`
- `Navigator.pop()`
- Transiciones con `PageRouteBuilder`
- Retorno correcto
- Flujo encadenado

---

## `custom_routes.dart` (Transiciones)

```dart
class CustomRoutes {
  static Route fade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route slide(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      },
    );
  }
}
```

---

## Requisitos por Pantalla

### 1) Splash Screen
- Logo del ecommerce
- Botón **"Ingresar"**
- Navega a **Login**

### 2) Login Screen
- Campo **email**
- Campo **password**
- Botón **Login** → **Home**

### 3) Home Screen
- Banner
- Botón **"Ver Categorías"**
- Botón **"Carrito"**

### 4) Categorías Screen
- **Grid** de categorías
- Al tocar → **Productos**

### 5) Productos Screen
- Lista de productos con **Card**
- Al tocar → **Detalle**

### 6) Detalle Producto
- Imagen
- Nombre
- Precio
- Botón **"Agregar al carrito"**

### 7) Carrito
- Lista de productos
- Total
- Botón **"Finalizar compra"**

### 8) Checkout
- Resumen
- Botón **"Confirmar pedido"**
- Mensaje de éxito

---

## Reto Adicional (Opcional)
Agregar:

- `BottomNavigationBar`
- `Drawer` lateral
- Estado global con **Provider**
- Persistencia de carrito

---

## Resultado Esperado
Una app Ecommerce con:

- Navegación profesional
- Flujo real de compra
- Interfaz moderna
- Arquitectura limpia
- Experiencia de usuario fluida
