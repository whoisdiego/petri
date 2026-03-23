# Reflexiones: Representaciones de Redes de Petri en Elixir

Elegí dos formas de representar las Redes de Petri: una con una lista de arcos [origen, destino], que es más parecida a la definición teórica, y otra usando un mapa donde cada transición ya tiene sus pre y post condiciones.

Con la lista de arcos, funciones como fire/3 y enablement/2 son más pesadas porque tienes que recorrer todos los arcos cada vez y además identificar cuáles nodos son transiciones. En cambio, con el mapa todo es más directo: puedes acceder rápido al preset y postset, y ya sabes cuáles son las transiciones con Map.keys/1.

En mi opinión, la lista está bien para cosas pequeñas o para entender el concepto, pero el mapa es mucho mejor cuando la red crece o necesitas hacer muchas simulaciones.