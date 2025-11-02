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
// cont(5) = 4
// porque 5 -> 3 * (5) + 1 = 16 -> 16 / 2 = 4 -> 4 / 2 = 2 -> 2 / 2 -> 1
// En total se realizó 4 veces la función dist
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
    writeln(count(5));
}