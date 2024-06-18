# Confocal-Collagen
La presente serie de simulaciones busca recrear las interacciones de una muestra colágeno tipo II en un sistema de iluminación confocal con láser ($\lambda=$ 520 $nm$).  pasa a través de un objetivo de microscopio con apertura numérica y distancia focal conocidas. El proceso de simulación se distribuye en tres etapas.

## Generación de la matriz extracelular
Se genera una estructura consistente en fibras de colágeno orientadas a lo largo del eje y que se encuentran en medio de un volumen de sustancia fundamental, éstas se ubican aleatoriamente con una probabilidad asociada a la densidad volumétrica del colágeno ($f_{v}$).

<img src='./Figuras/Estructura simulada.png' width=31%> <img src='./Figuras/Sección longitudinal.png' width=31%> <img src='./Figuras/Sección transversal.png' width=31%><img>

Estos dos materiales se representan mediante una serie de _voxels_ de tamaño definido que están caracterizados mediante el coeficiente de dispersión $\mu_{s} [cm^{-1}]$, el coeficiente de absorción $\mu_{a} [cm^{-1}]$ y el grado de anisotropía $g[1]$.

## Propagación del haz en la estructura
Se considera un haz con perfil gaussiano que se enfoca a una distancia conocida, 

## Reconstrucción de la irradiancia reflejada
Se limita la reconstrucción a los fotones provenientes de los _voxels_ comprendidos entre el plano focal y la ... dada por la teoría de los microscopios confocales. 
