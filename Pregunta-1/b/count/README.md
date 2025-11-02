# Mergesort

> Un programa que implementa el algoritmo de Collatz de un número y devuelve cuántas iteraciones debe hacer hasta llegar a 1

---

## Descripción

El programa implementa el algoritmo de Collatz, que es una función definida de la siguiente manera
- ```count(n) = n / 2        si n es par 
count(n) = 3 * n + 1    si n es impar```
Esta implementación se detiene cuando n = 1 y devuelve cuántas iteraciones tuvo que hacer.

---

## Lenguaje

- **D (Dlang)**

---

## Archivo principal
    count.d

---

## Compilación:
- ```dmd count.d```

---

## Ejecución normal:
- ```./count```

---

## Compilación con tests y cobertura:
- ```dmd count.d -unittest -cov```

---

## Ejecución con tests unitarios y cobertura:
- ```./count```