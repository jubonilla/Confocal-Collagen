# Confocal-Collagen
La presente serie de simulaciones busca recrear las interacciones de una muestra colágeno tipo II con un haz de láser ($\lambda=$ 520 $nm$) que pasa a través de un objetivo de microscopio con apertura numérica y distancia focal conocidas. El proceso de simulación se distribuye en tres etapas.

## Generación de la matriz extracelular
Se genera una estructura consistente en fibras de colágeno orientadas a lo largo del eje y que se encuentran en medio de un volumen de sustancia fundamental. Se supone que la densidad volumétrica del colágeno ($f_{v}$) es conocida y se usa esta para generar fibras de forma aleatoria.

<img src='./Figuras/Estructura simulada.png' width=28%><img src='./Figuras/Sección longitudinal.png' width=28%><img src='./Figuras/Sección transversal.png' width=28%><img>

## Propagación del haz en la estructura
Se considera un haz con perfil gaussiano que se enfoca a una distancia conocida, 

## Reconstrucción de la irradiancia reflejada
Se limita la reconstrucción a los fotones provenientes de los _voxels_ comprendidos entre el plano focal y la ... dada por la teoría de los microscopios confocales. 
