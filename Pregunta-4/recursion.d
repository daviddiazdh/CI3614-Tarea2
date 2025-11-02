import std.stdio;
import std.conv;

// =============================================================================================
// Función: f43
// =============================================================================================
// Función equivalente a la versión recursiva vista en el enunciado del ejercicio:
// f43(n) = n          si 0 <= n < 12
// f43(n) = f43(n - 3) + f43(n - 6) + f43(n - 9) + f43(n - 12)    si n >= 12
// Ejemplo de uso: 
// f43(13) = 22
// Porque f43(13) = f43(10) + f43(7) + f43(4) + f43(1) = 10 + 7 + 4 + 1 = 22 
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
int f43(int n){
    if(n >= 0 && n < 12){
        return n;
    }
    return f43(n - 3) + f43(n - 6) + f43(n - 9) + f43(n - 12);
}


// =============================================================================================
// Función: f43_tail_recursive
// =============================================================================================
// Función equivalente a la versión anterior, con la modificación necesaria para ser una recursión
// de cola. En vez de comenzar desde la n a consultar, se empieza desde el caso recursivo más
// pequeño, en este caso, f43(12). Esta va calculando las funciones para todos los i hasta que i == n.
// Ejemplo de uso: 
// f43_tail_recursive(13) = 22
// Porque f43(12) = 0 + 3 + 6 + 9 = 18
// Luego, se tiene el progress_array como [1,2,3,4,5,6,7,8,9,10,11,18], así que
// f_43_tail_recursive(13) = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9]
// f_43_tail_recursive(13) = 1 + 4 + 7 + 10 = 22
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
int f43_tail_recursive(int n, int[] progress_array = [0,1,2,3,4,5,6,7,8,9,10,11], int i = 12){

    if(n >= 0 && n < 12){
        return progress_array[n];
    }

    int new_value = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9];

    if(n == i){
        return new_value;
    }

    progress_array ~= new_value;
    return f43_tail_recursive(n, progress_array[1..$], i + 1);

}


// =============================================================================================
// Función: f43_iterative
// =============================================================================================
// Función totalmente equivalente a la función recursiva de cola, solo que es iterativa.
// Ejemplo de uso: 
// f43_tail_recursive(13) = 22
// Porque f43(12) = 0 + 3 + 6 + 9 = 18
// Luego, se tiene el progress_array como [1,2,3,4,5,6,7,8,9,10,11,18], así que
// f_43_tail_recursive(13) = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9]
// f_43_tail_recursive(13) = 1 + 4 + 7 + 10 = 22
// Si quiere más detalles de la implementación, recuerde que adjunta a la entrega hay un PDF técnico
// =============================================================================================
int f43_iterative(int n, int[] progress_array = [0,1,2,3,4,5,6,7,8,9,10,11], int i = 12){

    bool keep_going = true;
    int result;

    if(n >= 0 && n < 12){
        result = progress_array[n];
        keep_going = false;
    }

    while( keep_going ){

        int new_value = progress_array[0] + progress_array[3] + progress_array[6] + progress_array[9];

        if(n == i){
            result = new_value;
            break;
        }

        progress_array ~= new_value;
        progress_array = progress_array[1..$];
        i += 1;

    }

    return result;

}

void main() {
    // No hacemos nada acá
}

// ============================================================
// Pruebas unitarias
// ============================================================
unittest {
    import std.stdio;

    // =============================
    // Pruebas de consistencia entre f43, f43_tail_recursive y f43_iterative
    // =============================

    int[] casos = [0, 1, 5, 11, 12, 13, 14, 15, 16, 20];

    foreach (n; casos) {
        int r1 = f43(n);
        int r2 = f43_tail_recursive(n);
        int r3 = f43_iterative(n);

        assert(r1 == r2 && r2 == r3,
            "Error en n = " ~ to!string(n) ~
            " => f43 = " ~ to!string(r1) ~
            ", tail = " ~ to!string(r2) ~
            ", iter = " ~ to!string(r3));
    }

    writeln("Todas las funciones f43(), f43_tail_recursive() y f43_iterative() producen los mismos resultados.");
}