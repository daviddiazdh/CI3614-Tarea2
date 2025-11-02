import std.stdio;
import std.conv;

// =============================================================================================
// Función: count
// =============================================================================================
// Función que cuenta cuántas veces se debe aplicar la función dist a un número hasta que
// su resultado sea 1. La función dist es definida como
//     dist(n) = n / 2       si n es par
//     dist(n) = 3 * n + 1   si n es impar     
// Ejemplo de uso: 
// cont(5) = 5
// porque 5 -> 3 * (5) + 1 = 16 -> 16 / 2 = 8 -> 8 / 2 = 4 -> 4 / 2 = 2 -> 2 / 2 -> 1
// En total se realizó 5 veces la función dist
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
int count(int n, int acc = 0){
    if(n == 1){
        return acc;
    }
    // Si n es par, entonces hacemos recursión con n / 2
    if(n % 2 == 0){
        acc++;
        return count(n / 2, acc);
    // Si no, entonces hacemos recursión con 3n + 1
    } else {
        acc++;
        return count(3 * n + 1, acc);
    }
}

void main(){
    // No hacemos nada en el main porque se pidió la implementación de las funciones, 
    // no un programa
}


// =====================================
// Pruebas Unitarias
// =====================================
unittest {
    import std.stdio;

    // Caso base
    assert(count(1) == 0); // Ya está en 1, no hay pasos

    // Casos simples
    assert(count(2) == 1); // 2 → 1
    assert(count(3) == 7); // 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 (7 pasos)
    assert(count(4) == 2); // 4 → 2 → 1
    assert(count(5) == 5); // 5 → 16 → 8 → 4 → 2 → 1 (5 pasos)
    assert(count(6) == 8); // 6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 (8 pasos)
    assert(count(7) == 16); // Secuencia larga: 7 → ... → 1 (16 pasos)
    assert(count(8) == 3);  // 8 → 4 → 2 → 1
    assert(count(9) == 19); // 9 → ... → 1 (19 pasos)

    // Casos más grandes (para asegurar que no se desborda fácilmente)
    assert(count(10) == 6);
    assert(count(20) == 7);
    assert(count(27) == 111); // Famoso número de la conjetura de Collatz

    writeln("✅ Todos los casos de prueba para count() pasaron correctamente.");
}