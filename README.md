# VIGAS CARRILERAS DE GRÚAS - PUENTE[VIGAS CARRILERAS.pdf](https://github.com/AntonioMAGonzalezLopez/Carrileras/files/7963626/VIGAS.CARRILERAS.pdf)

Programa para calcular vigas carrileras con SILAB.
Las vigas carrileras han de soportar los esfuerzos dinámicos que les producen las grúas-puente al circular sobre ellas. Estos esfuerzos son debidos a las siguientes acciones:
- Carga a elevar.
- El peso de la grúa-puente.
- El peso de la propia viga (a comprobar al final).
- Elementos de suspensión de la carga en el gancho; como son: balancín, eslingas, etc. Todo elemento de sujeción de la carga.
- Fuerzas de inercia al comenzar a izarlas, o al frenar en su descenso.
- Al frenar la grúa-puente, actuará la componente horizontal de la carga suspendida, al balancearla en sentido transversal, además de la fuerza de inercia de la masa del carrito (se estima en un décimo de la vertical); o en sentido longitudinal en la frenada del puente en su traslación, donde interviene toda la masa de la grúa-puente, y la componente horizontal del balanceo de la carga, debido a la frenada puntual (se estima en un séptimo de la vertical). En el sentido trasversal producirá flexión horizontal, y en sentido longitudinal una compresión sobre la viga.

La mayoración de las cargas dependerá de la frecuencia de funcionamiento, y de la carga a elevar, si suele estar próxima al valor máximo.

No obstante, los datos de estas acciones los suele facilitar el fabricante de la grúa.

El programas ejecutable en SILAB:
- vigacarril.sce.

Las funciones complementarias:
- dimiu.sce.
- dimt.sce.
- rigid.sce.
- vuelco.sce

Facilitan las operaciones de cálculo de tanteo, salvando los datos en ficheros, para usarlos en las sucesivas funciones, simplificando su uso.
