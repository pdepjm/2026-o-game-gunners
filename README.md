### 114

* Achata Fernandez, Mayerly Romina
* Becerra, Ayelen Rosario
* Frino, Jimena
* Frutos, Matias Ignacio
* Vega Echeverria, Gonzalo Ezequiel

## Diagrama de Clases
https://docs.google.com/document/d/1m4Z_c8Wp6yi5p6OBwCgss6mUgDPLY7oPFzP-w7VPjao/edit?usp=sharing

## Gameplay en YouTube
https://youtu.be/fEQvZwwj2EQ

## PPT de la presentación
https://docs.google.com/presentation/d/1d0AfVXgj-A8xW3gTGPpP7s_3n5yPSa9HlQwrtqgq83A/edit?usp=sharing

## Explicación del juego
 
Manejás el colectivo de la línea 114 por las calles de la ciudad. El objetivo es juntar la mayor cantidad de pasajeros posible sin chocar. Cada pasajero que subís suma puntos y agrega un vagón que se engancha detrás del colectivo, así que a medida que juntás gente te vas haciendo más largo y es más difícil maniobrar.
 
El colectivo avanza solo; vos solo elegís hacia dónde doblar. No podés doblar en sentido contrario al que venís.
 
## Instrucciones
 
### Controles
 
| Tecla | Acción |
|-------|--------|
| **1** | Jugar el Nivel 1 (en la pantalla de inicio) |
| **2** | Jugar el Nivel 2 (en la pantalla de inicio) |
| **Flechas** | Doblar arriba, abajo, izquierda o derecha |
| **R** | Reanudar con una vida extra (en la pantalla de pérdida, si tenés vidas) |
| **Espacio** | Volver a la pantalla de inicio |
 
### Niveles
 
- **Nivel 1:** los bordes del mapa se comunican. Si salís por un lado, aparecés por el lado contrario. Los pasajeros cambian de lugar cada 6 segundos.
- **Nivel 2:** el mapa tiene paredes. Si chocás contra una, perdés. Los pasajeros quedan quietos hasta que los levantás.
### Pasajeros
 
- **Pasajero:** suma 10 puntos y 1 vagón.
- **Pasajero VIP:** suma 30 puntos y 3 vagones.
### Obstáculos
 
- **Pozo:** si caés, perdés.
- **Cabra:** te saca un vagón. Si no tenés vagones, perdés.
- **Mancha de aceite:** te hace ir más lento durante 5 segundos.
- **Cono (calle clausurada):** cierra una fila del tablero con vallas durante 8 segundos. Si chocás con una valla, perdés.
- **Corazón:** te da una vida extra.
### Cómo se pierde
 
- Chocar contra tu propio colectivo (los vagones).
- Caer en un pozo o chocar contra una valla.
- Chocar con una cabra sin tener vagones.
- Chocar contra una pared (Nivel 2).
Si tenés vidas, podés apretar **R** para seguir jugando desde el punto de inicio conservando tus vagones. Si no, aparece la pantalla de Game Over con tu puntaje final.
 
## Cómo ejecutarlo
 
1. Abrir el proyecto en Wollok.
2. Ejecutar el programa `L114Game`.
3. Elegir un nivel con las teclas 1 o 2.
## Estructura del proyecto
 
- `entidades.wlk`: colectivo, vagones y pasajeros.
- `obstaculos.wlk`: obstáculos (clase `Obstaculo` y sus subclases).
- `direcciones.wlk`: objetos de dirección (arriba, abajo, izquierda, derecha).
- `niveles.wlk`: configuración de cada nivel.
- `calles.wlk`: generación de los bordes que se comunican.
- `Inicioyfin.wlk`: pantallas, marcadores y administrador del juego.
- `tests.wtest`: tests automatizados.
